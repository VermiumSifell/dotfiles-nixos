{ config, lib, pkgs, ... }:

{
  users.users = {
    vermium = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "networkmanager" ];

      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDSajnZOE4R365L1nOucnEzxkfpuH6RIQkPYhqa2LfVfy9GUyg1Gl8R7Z32nYUwhIG8NXnhILiwJpzYejraoxe5Wvif7ZblrDH62Is4rrU3/+J3p1lYEQaMRTD9zK/CAvMxy45IcH24IHBTGjqWx4rGmzm6isKs1Bkglk1Q6jJF5YRAXImj0kkJ2kC4EQP8miu4TLdh95tvnArL2CyJ9y5p/M9b+to7+IMsap7x2r0O8HVpKRRCg5RifTcn/vtACU4wd9SPQMuoKmruMznCW4KKAtfNhw9D/WnoSwUe89x8NBBBlPfSrEDZY4Ky0QyswJWUHhRBFrr5u+D2Bb/I8AH50JqUSRKleAyR5VIdanIMzU8Y+CRQCyfihA8N4ba49Ae1Qa04z1EUtOFEh8gUfAAo9ARbs1z8GUQ1/VrY1tre3CA/npvvVC2fLrdVoxW2LisIBuGsq41ecYjbomhUF3uVGPlk/UxONZhKBEZvy2idF5C0rPIfLh+/IKqNc4dPdTp4a2ANFrZlf2ip7aEIJWn+/h/4UMfzvPXop1R1oCPKRvGBnx1QuKggM9v54hbcw8ONCHjYxNlu8JJ+8LPNHR750cvFoNjsmiCsa6BTZK+C2AWvgWwVKAx00W9N2nORKjdcxT94MYFyzA+k+JOX2yIHqQmgqg/T4eK8Q3dI5YHApQ== vermium@zyner.org"
      ];

      initialPassword = "welcome";
    };
  };
}
