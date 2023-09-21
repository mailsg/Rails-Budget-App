document.addEventListener('DOMContentLoaded', function () {
    setTimeout(hideSplashScreen, 3000);
    window.addEventListener('pageshow', function(event) {
        if (event.persisted) {
            hideSplashScreen();
        }
    });
});

function hideSplashScreen() {
    document.getElementById('splash-screen').style.display = 'none';
}