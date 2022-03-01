use crate::{log_header, log_install, os_package_manager::OsPackageManager, LogHeader};
use std::{process::Command, fmt::Display};

pub(crate) struct Homebrew;

impl LogHeader for Homebrew {
    fn log_header<T: Display>(msg: T) {
        log_header(format!("[{}] {}", <Self as OsPackageManager>::NAME, msg));
    }
}

impl OsPackageManager for Homebrew {
    const NAME: &'static str = "homebrew";
    const CMD: &'static str = "brew";

    // `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
    //
    fn install_itself() -> anyhow::Result<()> {
        let output = Command::new("curl")
            .arg("-fsSL")
            .arg("https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh")
            .output()?;

        // The stdout output is a shell script that needs to be executed.
        let stdout = std::str::from_utf8(&output.stdout)?;
        let mut child = Command::new("bash").arg("-c").arg(stdout).spawn()?;
        child.wait()?;
        Ok(())
    }

    // brew bundle --global
    //
    fn install_all_packages() -> anyhow::Result<()> {
        log_install("Homebrew Packages", || {
            let _ = Command::new("brew")
                .arg("bundle")
                .arg("--global")
                .output()?;
            Ok(())
        })
    }
}
