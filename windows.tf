resource "aws_key_pair" "mykey" {
key_name = "mykey"
public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}


resource "aws_instance" "winexample"  {
ami = "${lookup(var.WIN_AMIS, var.aws_region)}"
instance_type = "t2.micro"
key_name = "mykey"
user_data = <<EOF
<powershell>
net user '${var.INSTANCE_USERNAME}''${var.INSTANCE_PASSWORD}'/add/y
net localgroup administrators '${var.INSTANCE_USERNAME}'/add/y


winrm quickconfig
y
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM 5986" portocol=TCP dir=in localport=5986 action=allow


sc.exe config winrm start=auto
net start winrm

</powershell>
EOF


connection {
type = "winrm"
timeout = "3m"
user = "${var.INSTANCE_USERNAME}"
password = "${var.INSTANCE_PASSWORD}"
}
vpc_security_group_ids=["${aws_security_group.allow-all.id}"]

}

output "ip"  {
value = "${aws_instance.winexample.public_ip}"
}

