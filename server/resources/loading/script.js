// ==========================================
// DEBUG COMPLETO
// ==========================================
console.log('=== DEBUG LOADSCREEN ===');
console.log('Página carregou:', new Date().toLocaleTimeString());

const video = document.getElementById('bg-video');
const audio = document.getElementById('bg-audio');
const playPauseBtn = document.getElementById('play-pause-btn');
const muteBtn = document.getElementById('mute-btn');
const volumeSlider = document.getElementById('volume-slider');

console.log('Elemento vídeo:', video);
console.log('Elemento áudio:', audio);

if (video) {
    console.log('Vídeo src:', video.querySelector('source')?.src);

    video.addEventListener('loadedmetadata', () => {
        console.log('✅ loadedmetadata — duração:', video.duration);
    });
    video.addEventListener('loadeddata', () => {
        console.log('✅ loadeddata — vídeo pronto');
    });
    video.addEventListener('canplay', () => {
        console.log('✅ canplay — pode tocar');
    });
    video.addEventListener('playing', () => {
        console.log('✅ playing — vídeo rodando!');
    });
    video.addEventListener('error', (e) => {
        console.error('❌ ERRO no vídeo');
        console.error('  Código:', video.error?.code);
        console.error('  Mensagem:', video.error?.message);
        // Códigos: 1=ABORTED, 2=NETWORK, 3=DECODE, 4=SRC_NOT_SUPPORTED
    });
}

// ==========================================
// FORÇA O VÍDEO A TOCAR
// ==========================================
function forcarVideo() {
    if (!video) return;
    video.muted = true;
    video.playsInline = true;
    video.setAttribute('playsinline', '');
    video.setAttribute('webkit-playsinline', '');

    console.log('Tentando dar play. Estado:', video.paused ? 'pausado' : 'rodando');

    const tentativa = video.play();
    if (tentativa !== undefined) {
        tentativa.then(() => {
            console.log('✅ play() resolveu com sucesso');
        }).catch(err => {
            console.error('❌ play() falhou:', err.name, '-', err.message);
            setTimeout(() => {
                video.play().then(() => console.log('✅ 2ª tentativa OK')).catch(() => {});
            }, 500);
        });
    }
}

document.addEventListener('DOMContentLoaded', forcarVideo);
window.addEventListener('load', forcarVideo);
setTimeout(forcarVideo, 200);
setTimeout(forcarVideo, 1000);
setTimeout(forcarVideo, 3000);

// ==========================================
// ÁUDIO
// ==========================================
if (audio) {
    audio.volume = volumeSlider.value / 100;
    audio.play().then(() => {
        console.log('✅ Áudio rodando');
    }).catch((err) => {
        console.log('❌ Áudio bloqueado:', err.name);
        playPauseBtn.classList.replace('fa-pause', 'fa-play');
    });
}

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
// SINCRONIZAÇÃO FIVEM
// ==========================================
const progressFill = document.getElementById('progress-fill');
const progressText = document.getElementById('progress-text');
const loadingSub = document.getElementById('loading-sub');

let shutdownCalled = false;

function killFiveMLoadscreen() {
    try {
        if (typeof ShutdownLoadingScreenNui === 'function') ShutdownLoadingScreenNui();
    } catch (e) {}
    try {
        if (typeof ShutdownLoadingScreen === 'function') ShutdownLoadingScreen();
    } catch (e) {}
}

window.addEventListener('message', function (e) {
    if (e.data.eventName === 'loadProgress') {
        let loadPercentage = Math.floor(e.data.loadFraction * 100);
        if (loadPercentage > 100) loadPercentage = 100;

        progressFill.style.width = loadPercentage + '%';
        progressText.innerText = loadPercentage + '%';

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

setTimeout(function () {
    if (!shutdownCalled) {
        shutdownCalled = true;
        killFiveMLoadscreen();
    }
}, 60000);