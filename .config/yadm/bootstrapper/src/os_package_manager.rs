use crate::{command_exists, log_group, log_header, LogHeader};

pub(crate) trait OsPackageManager: crate::LogHeader {
    const NAME: &'static str;
    const CMD: &'static str;

    fn check_and_install() -> anyhow::Result<()> {
        log_group(format!("os-pkg-mgr: {}", Self::NAME), || {
            if Self::exists() {
                return Ok(());
            }

            Self::install_itself()
        })
    }

    fn exists() -> bool {
        command_exists(Self::CMD)
    }

    fn install_itself() -> anyhow::Result<()>;
    fn install_all_packages() -> anyhow::Result<()>;

    fn _install_itself() -> anyhow::Result<()> {
        <Self as LogHeader>::log_header("Installing self...");
        Self::install_itself()?;
        <Self as LogHeader>::log_header("Done.");

        Ok(())
    }

    fn _install_all_packages() -> anyhow::Result<()> {
        log_header(format!("[{}.all_packages] Installing...", Self::NAME));
        Self::install_all_packages()?;
        log_header(format!("[{}.all_packages] Done.", Self::NAME));

        Ok(())
    }
}
