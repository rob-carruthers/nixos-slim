{ pkgs, ... }:

{
  systemd.services.battery-conservative = {
    description = "Enable Lenovo Ideapad Battery Conservation Mode";

    after = [ "sys-bus-platform-drivers-ideapad_acpi.device" ];

    unitConfig.ConditionPathExists = "/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode";

    serviceConfig = {
      Type = "oneshot";

      ExecStart = pkgs.writeShellScript "enable-conservation-mode" ''
        echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
      '';
    };

    wantedBy = [ "multi-user.target" ];
  };
}
