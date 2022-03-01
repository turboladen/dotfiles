use std::path::Path;

use crate::{
    app::{App, AppPluginManager},
    log_group,
};
use anyhow::anyhow;
use git2::Repository;
use log::info;

pub(crate) struct Tmux;

impl App for Tmux {
    const CMD: &'static str = "tmux";
    type PluginManager = Tpm;

    fn check_and_install() -> anyhow::Result<()> {
        log_group("tmux", || {
            if !Self::exists() {
                return Err(anyhow!("`tmux` not installed!"));
            }

            Self::install_plugin_manager()?;
            Self::install_plugins()
        })
    }
}

pub(crate) struct Tpm;

impl AppPluginManager for Tpm {
    const NAME: &'static str = "tpm";
    const ROOT_DIR: &'static str = ".tmux/plugins/tpm2";

    fn exists() -> bool {
        Path::new(Self::ROOT_DIR).exists() && dirs::home_dir().unwrap().join(".tmux.conf").exists()
    }

    fn install_itself() -> anyhow::Result<()> {
        const TPM_REPO: &str = "https://github.com/tmux-plugins/tpm";

        let actual_root_dir = dirs::home_dir().unwrap().join(Self::ROOT_DIR);

        info!(
            "[{}] Cloning '{}' to '{}'",
            Self::NAME,
            TPM_REPO,
            actual_root_dir.display()
        );
        let _repo = Repository::clone(TPM_REPO, actual_root_dir)?;
        info!("[{}] More to do; check instructions at 'https://github.com/tmux-plugins/tpm#installation'", Self::NAME);
        info!("[{}] Done.", Self::NAME);

        Ok(())
    }

    fn install_all_packages() -> anyhow::Result<()> {
        Ok(())
    }
}
