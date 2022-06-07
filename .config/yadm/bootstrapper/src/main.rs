#[cfg(target_os = "macos")]
mod macos;

#[cfg(target_os = "linux")]
mod ubuntu;

mod setup_development_directories;

use log::LevelFilter;
use simplelog::{ColorChoice, Config, TermLogger, TerminalMode};
use stromboli::{
    actions::Action,
    apps::app::Tmux,
    install::{IdempotentInstallWithLogging, IsInstalled},
    languages::version_manager::{RubyInstall, VersionManager},
    os_package_managers::OsPackageManager,
    NewPluginManager,
};

use self::setup_development_directories::SetupDevelopmentDirectories;

// NOTES:
// * macOS
//      * We install chruby, ruby-install using homebrew, so don't install those.
fn main() -> anyhow::Result<()> {
    init_logging();

    let bootstrapper = bootstrapper();
    let os_package_manager = bootstrapper.os_package_manager();
    bootstrapper.install_os_packages(&os_package_manager)?;

    bootstrapper.setup_tmux()?;
    let ruby_install = bootstrapper.setup_ruby_version_managers()?;
    bootstrapper.setup_ruby(&ruby_install)?;

    bootstrapper.setup_development_directories()?;

    Ok(())
}

#[cfg(target_os = "macos")]
fn bootstrapper() -> impl Bootstrapper {
    macos::MacOS
}

fn init_logging() {
    TermLogger::init(
        LevelFilter::Info,
        Config::default(),
        TerminalMode::Mixed,
        ColorChoice::Auto,
    )
    .unwrap();
}

pub(crate) trait Bootstrapper {
    type PackageManager: OsPackageManager;

    fn os_package_manager(&self) -> Self::PackageManager {
        Self::PackageManager::default()
    }

    fn install_os_packages(&self, package_manager: &Self::PackageManager) -> anyhow::Result<()> {
        package_manager.install_all_packages_with_logging()?;
        Ok(())
    }

    fn setup_tmux(&self) -> anyhow::Result<()> {
        let tmux = Tmux::default();

        if !tmux.is_installed() {
            return Err(stromboli::Error::NotInstalled("tmux".to_string()).into());
        }

        let tpm = tmux.new_plugin_manager();
        tpm.idempotent_install_with_logging()?;
        Ok(())
    }

    fn setup_ruby_version_managers(&self) -> anyhow::Result<RubyInstall>;

    fn setup_ruby(&self, version_manager: &RubyInstall) -> anyhow::Result<()> {
        version_manager.install_language_version([
            "--no-reinstall",
            "ruby",
            "--",
            "--enable-shared",
        ])?;

        Ok(())
    }

    fn setup_development_directories(&self) -> anyhow::Result<()> {
        SetupDevelopmentDirectories::default().act()?;
        Ok(())
    }

    fn setup_extras(&self) -> anyhow::Result<()> {
        Ok(())
    }
}
