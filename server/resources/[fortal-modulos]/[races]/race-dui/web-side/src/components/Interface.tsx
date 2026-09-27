import type { Action, Data } from "@/types"

import { useData } from "@/hooks/useData"
import { useEffect } from "react"

export default function Interface() {
  const dataProvider = useData()
  const data: Data | null = dataProvider!.current

  useEffect(() => {
    const eventListener = (event: MessageEvent) => {
      if (event.data && dataProvider) {
        dataProvider.set(event.data)
      }
    }
    window.addEventListener("message", eventListener)
    return () => window.removeEventListener("message", eventListener)
  }, [])

  if (data) {
    if ((data as Action).distance !== undefined && (data as Action).MaxLaps && (data as Action).laps) {
      return (
        <div className="flex flex-col items-center">
          <p className="text-[20px] text-[#FFFFFFCC]">
            {(data as Action).laps} <span className="text-[#FFFFFF73]">/</span> {(data as Action).MaxLaps}
          </p>
          <h1 className="text-[40px] font-[700] text-white">CHECKPOINT</h1>
          <p className="mb-[1vw] text-[20px] text-[#FFFFFF8C]">{(data as Action).distance}m</p>
          <svg width="31" height="99" viewBox="0 0 31 99" fill="none" xmlns="http://www.w3.org/2000/svg">
            <circle cx="15.5" cy="15.5" r="15" fill="#389EFF" fillOpacity="0.05" stroke="#389EFF" />
            <circle cx="15.5" cy="15.5" r="5.5" fill="#389EFF" />
            <rect x="14" y="30" width="3" height="69" fill="url(#paint0_linear_920_20)" />
            <defs>
              <linearGradient
                id="paint0_linear_920_20"
                x1="15.5"
                y1="30"
                x2="15.5"
                y2="99"
                gradientUnits="userSpaceOnUse"
              >
                <stop stopColor="#389EFF" />
                <stop offset="1" stopColor="#389EFF" stopOpacity="0" />
              </linearGradient>
            </defs>
          </svg>
        </div>
      )
    }
  }

  return <></>
}
