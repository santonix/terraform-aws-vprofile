resource "aws_key_pair" "vprofilekey" {
    public_key =  file(var.PUBBLIC_KEY_PATH)
}