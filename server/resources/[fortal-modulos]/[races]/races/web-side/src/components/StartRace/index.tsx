import "./startrace.css"

import { useEffect, useState } from "react"

interface StartRaceComponent {
  messageData: {
    values: {
      time: number
    }
  }
}

export function StartRace({ messageData }: StartRaceComponent) {
  const { time } = messageData.values
  const [currentTime, setCurrentTime] = useState(time)
  const [showGo, setShowGo] = useState(false)
  const [isVisible, setIsVisible] = useState(true)

  useEffect(() => {
    if (time <= 0) return

    const interval = setInterval(() => {
      setCurrentTime((prev) => {
        const next = prev - 100

        // Quando chegar a 1 segundo (1000ms), mostrar GO
        if (next <= 1000 && next > 0) {
          setShowGo(true)
          return next
        }

        // Quando chegar a 0, esconder o componente após um breve momento
        if (next <= 0) {
          clearInterval(interval)
          setTimeout(() => {
            setIsVisible(false)
          }, 100) // Pequeno delay para garantir que GO seja visto
          return 0
        }

        return next
      })
    }, 100)

    return () => clearInterval(interval)
  }, [time])

  // Se não está visível, não renderiza nada
  if (!isVisible) {
    return null
  }

  // Mostrar GO quando showGo for true OU quando currentTime <= 1000
  const displayGo = showGo || currentTime <= 1000
  const displayNumber = displayGo ? "GO" : Math.max(1, Math.ceil(currentTime / 1000) - 1)

  return (
    <div className="mainStart">
      <p>{displayNumber}</p>
      <h1 className="outline-text">{displayNumber}</h1>
    </div>
  )
}
