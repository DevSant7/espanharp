$(document).ready(() => {
  let currentSpeaker = null
  let hideTimeout = null

  window.addEventListener("message", (event) => {
    const data = event.data

    switch (data.action) {
      case "showVoiceIndicator":
        showVoiceIndicator(data.playerName)
        break
      case "hideVoiceIndicator":
        hideVoiceIndicator()
        break
      case "updateFrequency":
        break
      case "voiceStart":
        startVoiceAnimation(data.playerName)
        break
      case "voiceStop":
        stopVoiceAnimation()
        break
      case "checkNUI":
        showVoiceIndicator("TESTE")
        setTimeout(() => {
          hideVoiceIndicator()
        }, 3000)
        break
    }
  })

  function showVoiceIndicator(playerName) {
  
    currentSpeaker = playerName

    let displayName = playerName || "Desconhecido"
    if (displayName.length > 12) {
      displayName = displayName.split(" ")[0]
    }

    $("#speaker-name").text(displayName)

    $("#voice-indicator").show()
    $("#voice-indicator").css("display", "flex") 


    if (hideTimeout) {
      clearTimeout(hideTimeout)
    }

    hideTimeout = setTimeout(() => {
  
      if (!$("#voice-indicator").hasClass("voice-active")) {
        hideVoiceIndicator()
      }
    }, 4000)
  }

  function hideVoiceIndicator() {

    $("#voice-indicator").removeClass("voice-active")
    $("#voice-indicator").fadeOut(200)
    currentSpeaker = null

    if (hideTimeout) {
      clearTimeout(hideTimeout)
      hideTimeout = null
    }
  }

  function startVoiceAnimation(playerName) {


    if (playerName) {
      let displayName = playerName
      if (displayName.length > 12) {
        displayName = displayName.split(" ")[0]
      }
      $("#speaker-name").text(displayName)
    }

    $("#voice-indicator").addClass("voice-active")
    $("#voice-indicator").show()
    $("#voice-indicator").css("display", "flex")

  


    if (hideTimeout) {
      clearTimeout(hideTimeout)
      hideTimeout = null
    }
  }

  function stopVoiceAnimation() {

    $("#voice-indicator").removeClass("voice-active")

    hideTimeout = setTimeout(() => {
      hideVoiceIndicator()
    }, 1500)
  }
})
