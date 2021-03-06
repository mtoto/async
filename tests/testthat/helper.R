
httpbin_url <- function() {
  "eu.httpbin.org"
}

is_offline <- (function() {
  offline <- NULL
  function() {
    if (is.null(offline)) {
      offline <<- tryCatch(
        is.na(pingr::ping_port(httpbin_url(), port = 443, count = 1L)),
        error = function(e) TRUE
      )
    }
    offline
  }
})()

skip_if_offline <- function() {
  if (is_offline()) skip("Offline")
}
