
source "yandex" "debian_docker" {
  disk_type           = "network-hdd"
  folder_id           = "b1gcueo7ju4uif0skn7d"
  image_description   = "my custom debian with docker"
  image_name          = "debian-11-docker"
  source_image_family = "debian-11"
  ssh_username        = "debian"
  subnet_id           = "e9bm0tgtlgsa6ouf6a9g"
  token               = "xxx"
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
}

build {
  sources = ["source.yandex.debian_docker"]

  provisioner "shell" {
    inline = [
        "sudo sed -i '/bullseye-backports/ s/^/#/' /etc/apt/sources.list",
        "echo 'hello from packer'",
        "sudo apt update",
        "sudo apt install htop tmux curl gnupg ca-certificates -y",
        "curl -fsSL https://get.docker.com -o get-docker.sh",
        "sudo sh get-docker.sh",
        "sudo useradd -m -s /bin/bash stas",
        "sudo mkdir -p /home/stas/.ssh",
        "sudo chmod 700 /home/stas/.ssh",
        "echo 'xxx' | sudo tee /home/stas/.ssh/authorized_keys",
        "sudo chmod 600 /home/stas/.ssh/authorized_keys",
        "sudo chown -R stas:stas /home/stas/.ssh"

    ]
  }

}