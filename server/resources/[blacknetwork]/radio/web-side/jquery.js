$(document).ready(() => {

  
    $("#freq").focus(function () {
      $(this).val("")
    })
  
    window.addEventListener("message", (event) => {
     
  
      switch (event.data.action) {
        case "showMenu":
          $("#actionmenu").css("display", "block")
          break
        case "hideMenu":
          $("#actionmenu").css("display", "none")
          break
      }
    })
  
    document.onkeyup = (data) => {
      const key = data.key
      switch (key) {
        case "Escape":
          $("#actionmenu").css("display", "none")
          $.post("http://radio/radioClose")
          break
        case "Enter":
          $("#freq").blur()
          setFrequency()
          break
      }
    }
  })
  
  $(document).on(
    "click",
    ".ativar",
    debounce(() => {
      setFrequency()
    }),
  )
  
  $(document).on(
    "click",
    ".desativar",
    debounce(() => {
      $.post("http://radio/inativeFrequency")
    }),
  )
  
  function debounce(func, immediate) {
    var timeout
    return function () {
      var args = arguments
      var later = () => {
        timeout = null
        if (!immediate) func.apply(this, args)
      }
      var callNow = immediate && !timeout
      clearTimeout(timeout)
      timeout = setTimeout(later, 500)
      if (callNow) func.apply(this, args)
    }
  }
  
  const setFrequency = debounce(() => {
    const freq = Number.parseInt($("#freq").val())
    if (freq > 0) {
      $.post("http://radio/activeFrequency", JSON.stringify({ freq }))
    }
  })
  