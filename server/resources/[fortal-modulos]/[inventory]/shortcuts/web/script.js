window.addEventListener("message", (event) => {
  const { action, payload } = event.data

  const shortcuts = document.querySelector(".shortcuts-main")
  const body = document.querySelector("body")

  switch (action) {
    case "Open":
      body.style.display = "flex"
      insert(payload)
      break

    case "Close":
      body.style.display = "none"
      break

    default:
      body.style.display = "none"
  }
})

const insert = (shortcutsData) => {
  const container = document.querySelector(".shortcuts")
  if (container) {
    container.innerHTML = ""

    // Create 5 slots (1-5)
    for (let i = 1; i <= 5; i++) {
      const slotKey = (i + 35).toString()
      const item = shortcutsData[slotKey]

      const shortcutDiv = document.createElement("div")
      shortcutDiv.classList.add("shortcut")

      if (item) {
        // Item exists
        shortcutDiv.classList.add("has-item")

        // Item image only
        const img = document.createElement("img")
        img.src = `https://cdn.blacknetwork.com.br/black_inventory/${item}.png`
        img.alt = item
        shortcutDiv.appendChild(img)
      } else {
        // Empty slot
        shortcutDiv.classList.add("empty")

        const emptyNumber = document.createElement("h3")
        emptyNumber.classList.add("empty-number")
        emptyNumber.textContent = i.toString()
        shortcutDiv.appendChild(emptyNumber)
      }

      container.appendChild(shortcutDiv)
    }
  }
}
