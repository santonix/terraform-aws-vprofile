resource "aws_key_pair" "vprofilekey" {
 HEAD
  
  public_key = file(var.PUBBLIC_KEY_PATH)

  tags = {
    Name = "vprofilekey"
  }

    public_key =  file(var.PUBBLIC_KEY_PATH)
>>>>>>> dcf5ec07ec1f2bdfc3aa8827104c80ec13f0159d
}