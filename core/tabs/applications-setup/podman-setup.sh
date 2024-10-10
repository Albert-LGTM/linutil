#!/bin/sh -e

. ../common-script.sh

install_podman() {
    printf "%b\n" "${YELLOW}Installing Podman...${RC}"
    case "$PACKAGER" in
        apt-get|nala)
            "$ESCALATION_TOOL" "$PACKAGER" install -y podman
            ;;
        zypper)
            "$ESCALATION_TOOL" "$PACKAGER" --non-interactive install podman
            ;;
        pacman)
            "$ESCALATION_TOOL" "$PACKAGER" -S --noconfirm --needed podman
            ;;
        dnf)
            "$ESCALATION_TOOL" "$PACKAGER" install -y podman
            ;;
        *)
            printf "%b\n" "${RED}Unsupported package manager: ""$PACKAGER""${RC}"
            exit 1
            ;;
    esac
}

install_components() {
    if ! command_exists podman; then
        install_podman
    else
        printf "%b\n" "${GREEN}Podman is already installed.${RC}"
    fi
}

checkEnv
checkEscalationTool
install_components