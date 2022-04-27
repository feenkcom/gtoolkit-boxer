use crate::ValueBox;
use thiserror::Error;
use user_error::{UserFacingError, UFE};

const SUMMARY_PREFIX: &str = "\u{001b}[97;41;22mError:\u{001b}[91;49;1m ";
const RESET: &str = "\u{001b}[0m";
const REASON_PREFIX: &str = "\u{001b}[93;49;1m - \u{001b}[97;49;1m";

#[derive(Error, Debug)]
pub enum BoxerError {
    #[error("The pointer to the box of type {0} is null")]
    NullPointer(String),
    #[error("There is not value of type {0} in the box")]
    NoValue(String),
    #[error("There was an error")]
    AnyhowError(#[from] anyhow::Error),
    #[error("There was an IO error")]
    IOError(#[from] std::io::Error),
    #[error("There was an error")]
    AnyError(#[from] Box<dyn std::error::Error>),
}

impl<T> From<BoxerError> for core::result::Result<T, BoxerError> {
    fn from(error: BoxerError) -> Self {
        Err(error)
    }
}

pub type Result<T> = core::result::Result<T, BoxerError>;

pub trait ReturnBoxerResult<Return> {
    fn into_raw(self) -> *mut ValueBox<Return>;
    fn log(self);
    fn or_log(self, value: Return) -> Return;
    fn or_print(self, value: Return) -> Return;
}

impl<Return> ReturnBoxerResult<Return> for Result<Return> {
    fn into_raw(self) -> *mut ValueBox<Return> {
        self.map(|value| ValueBox::new(value).into_raw())
            .or_log(std::ptr::null_mut())
    }

    fn log(self) {
        if let Err(error) = self {
            log_boxer_error(error);
        }
    }

    fn or_log(self, value: Return) -> Return {
        self.unwrap_or_else(|error| {
            log_boxer_error(error);
            value
        })
    }

    fn or_print(self, value: Return) -> Return {
        self.map_err(|error| {
            let error: Box<dyn std::error::Error> = Box::new(error);
            let user_facing_error: UserFacingError = error.into();
            user_facing_error
        })
        .unwrap_or_else(|error| {
            println!("{}", pretty_summary(error.summary().as_str()));
            if let Some(reasons) = pretty_reasons(error.reasons()) {
                println!("{}", reasons);
            }
            value
        })
    }
}

fn log_boxer_error(error: BoxerError) {
    match &error {
        BoxerError::NullPointer(_) => warn_user_facing_error(to_user_facing_error(error)),
        BoxerError::NoValue(_) => warn_user_facing_error(to_user_facing_error(error)),
        _ => error_user_facing_error(to_user_facing_error(error)),
    };
}

fn warn_user_facing_error(error: UserFacingError) {
    warn!("{}", pretty_summary(error.summary().as_str()));
    if let Some(reasons) = pretty_reasons(error.reasons()) {
        warn!("{}", reasons);
    }
}

fn error_user_facing_error(error: UserFacingError) {
    error!("{}", pretty_summary(error.summary().as_str()));
    if let Some(reasons) = pretty_reasons(error.reasons()) {
        error!("{}", reasons);
    }
}

fn to_user_facing_error(error: BoxerError) -> UserFacingError {
    let error: Box<dyn std::error::Error> = Box::new(error);
    let user_facing_error: UserFacingError = error.into();
    user_facing_error
}

fn pretty_summary(summary: &str) -> String {
    [SUMMARY_PREFIX, summary, RESET].concat()
}

fn pretty_reasons(reasons: Option<Vec<String>>) -> Option<String> {
    reasons.map(|reasons| {
        let mut reason_strings = Vec::with_capacity(reasons.len());
        for reason in reasons {
            let bullet_point = [REASON_PREFIX, &reason].concat();
            reason_strings.push(bullet_point);
        }
        [&reason_strings.join("\n"), RESET].concat()
    })
}
