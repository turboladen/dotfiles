pub(crate) mod app;
pub(crate) mod os_package_manager;

#[cfg(target_os = "macos")]
mod homebrew;
mod tmux;

use std::{
    fmt::Display,
    process::{Command, Stdio},
};

use self::{app::App, os_package_manager::OsPackageManager};
use log::LevelFilter;
use simplelog::{ColorChoice, Config, TermLogger, TerminalMode};

fn main() -> anyhow::Result<()> {
    init_logging();

    if cfg!(target_os = "macos") {
        homebrew::Homebrew::check_and_install()?;
    }

    tmux::Tmux::check_and_install()?;

    log_header("Done done.");

    Ok(())
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

pub(crate) trait LogHeader {
    fn log_header<T: Display>(msg: T);
}

pub(crate) fn log_group<T, F, O>(group_name: T, f: F) -> anyhow::Result<O>
where
    T: Display,
    F: Fn() -> Result<O, anyhow::Error>,
{
    log_header(format!("[{}]", group_name));
    let output = f()?;
    log_header(format!("[{}] Done.", group_name));

    Ok(output)
}

pub(crate) fn log_install<T, F, O>(group_name: T, f: F) -> anyhow::Result<O>
where
    T: Display,
    F: Fn() -> Result<O, anyhow::Error>,
{
    log_header(format!("[{}]...", group_name));
    let output = f()?;
    log_header(format!("[{}] Done installing.", group_name));

    Ok(output)
}

pub(crate) fn log_header<T: Display>(inner: T) {
    log_dashed_line();
    log::info!("{inner}");
    log_dashed_line();
}

pub(crate) fn log_dashed_line() {
    log::info!("-----------------------------------------------------------------------");
}

pub(crate) fn command_exists(the_command: &str) -> bool {
    log::info!("Checking for `{the_command}`...");

    let c = Command::new("command")
        .arg("-v")
        .arg(the_command)
        .stdout(Stdio::null())
        .spawn();

    match c {
        Ok(_) => {
            log::info!("`{the_command}` exists.");
            true
        }
        Err(_) => {
            log::error!("`{the_command}` not found.");
            false
        }
    }
}
