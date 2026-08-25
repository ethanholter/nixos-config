{ ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        ControllerMode = "dual";
        KernelExperimental = "6fbaf188-05e0-496a-9885-d6ddfdb4e03e";
      };
    };
  };
  services.blueman.enable = true;
}
