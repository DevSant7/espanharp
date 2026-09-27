// ==========================================
// 1. CONTROLE DO PLAYER DE MÚSICA
// ==========================================
const audio = document.getElementById('bg-audio');
const playPauseBtn = document.getElementById('play-pause-btn');
const muteBtn = document.getElementById('mute-btn');
const volumeSlider = document.getElementById('volume-slider');

audio.volume = volumeSlider.value / 100;

audio.play().catch(function (err) {
    console.log("Autoplay bloqueado, aguardando interação do usuário.");
    playPauseBtn.classList.replace('fa-pause', 'fa-play');
});

playPauseBtn.addEventListener('click', () => {
    if (audio.paused) {
        audio.play();
        playPauseBtn.classList.replace('fa-play', 'fa-pause');
    } else {
        audio.pause();
        playPauseBtn.classList.replace('fa-pause', 'fa-play');
    }
});

volumeSlider.addEventListener('input', (e) => {
    audio.volume = e.target.value / 100;
    if (audio.volume === 0) {
        muteBtn.classList.replace('fa-volume-up', 'fa-volume-mute');
    } else {
        muteBtn.classList.replace('fa-volume-mute', 'fa-volume-up');
    }
});

muteBtn.addEventListener('click', () => {
    if (audio.volume > 0) {
        audio.volume = 0;
        volumeSlider.value = 0;
        muteBtn.classList.replace('fa-volume-up', 'fa-volume-mute');
    } else {
        audio.volume = 0.3;
        volumeSlider.value = 30;
        muteBtn.classList.replace('fa-volume-mute', 'fa-volume-up');
    }
});

// ==========================================
// 2. SINCRONIZAÇÃO COM O CARREGAMENTO DO FIVEM
// ==========================================
const progressFill = document.getElementById('progress-fill');
const progressText = document.getElementById('progress-text');
const loadingSub = document.getElementById('loading-sub');

let shutdownCalled = false;

// 🔥 Mata a tela de loading do FiveM (as 2 funções)
function killFiveMLoadscreen() {
    try {
        if (typeof ShutdownLoadingScreenNui === 'function') {
            ShutdownLoadingScreenNui();
        }
    } catch (e) { console.log("ShutdownLoadingScreenNui:", e); }
    
    try {
        if (typeof ShutdownLoadingScreen === 'function') {
            ShutdownLoadingScreen();
        }
    } catch (e) { console.log("ShutdownLoadingScreen:", e); }
}

// 🔥 Sempre que o progresso atualizar, atualiza a barra
window.addEventListener('message', function (e) {
    if (e.data.eventName === 'loadProgress') {
        let loadPercentage = Math.floor(e.data.loadFraction * 100);
        if (loadPercentage > 100) loadPercentage = 100;

        progressFill.style.width = loadPercentage + '%';
        progressText.innerText = loadPercentage + '%';

        // 🔥 Quando chegar a 100%, mata a tela
        if (loadPercentage >= 100 && !shutdownCalled) {
            shutdownCalled = true;
            setTimeout(killFiveMLoadscreen, 200);
            setTimeout(killFiveMLoadscreen, 1000);
            setTimeout(killFiveMLoadscreen, 3000);
        }
    }

    if (e.data.eventName === 'onLogLine') {
        loadingSub.innerText = e.data.message;
    }
});

// 🔥 Fallback: se por algum motivo o progresso não chegar a 100%,
// mata a tela depois de 60 segundos
setTimeout(function () {
    if (!shutdownCalled) {
        shutdownCalled = true;
        killFiveMLoadscreen();
    }
}, 60000);