use crate::command_exists;
use std::path::Path;

pub(crate) trait App {
    const CMD: &'static str;

    type PluginManager: AppPluginManager;

    fn check_and_install() -> anyhow::Result<()>;

    fn exists() -> bool {
        command_exists(Self::CMD)
    }

    fn install_plugin_manager() -> anyhow::Result<()> {
        <Self::PluginManager as AppPluginManager>::install_itself()
    }

    fn install_plugins() -> anyhow::Result<()> {
        <Self::PluginManager as AppPluginManager>::install_all_packages()
    }
}

pub(crate) trait AppPluginManager {
    const NAME: &'static str;
    const ROOT_DIR: &'static str;

    fn exists() -> bool {
        Path::new(Self::ROOT_DIR).exists()
    }

    fn install_itself() -> anyhow::Result<()>;
    fn install_all_packages() -> anyhow::Result<()>;
}
