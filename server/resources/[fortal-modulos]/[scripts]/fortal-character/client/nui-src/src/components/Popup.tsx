import { useState, useEffect } from "react";
import { type Popup, usePopup } from "@/stores/usePopup"; 
import { AnimationProvider } from "@/providers/Animation";
import { cn } from "@/utils/misc";

export default function Popup() {
  const { current: popup, set: setPopup } = usePopup();
  const [data, setData] = useState<Popup | false>(false)

  useEffect(() => {
    if (popup) {
      setData(popup)
    } else {
      setTimeout(() => setData(false), 2000)
    }
  })

  return (  
    <AnimationProvider show={!!popup}>
      <div className="absolute flex justify-center items-center bg-black/80 top-0 left-0 w-full h-full z-[1000]">
        <div
          onClick={() => setPopup(false)} 
          className="absolute w-full h-full"
        ></div>
        
        <div className={cn(
            "flex flex-col justify-between p-4 gap-10", 
            "bg-section rounded z-[1000]", 
            "border-solid border-[.1vw] border-white/10"
        )}>
          {data && <> 
            <header className="flex flex-col items-center">
              <h1 className="font-bold text-white text-[1.3rem]">{data.title}</h1>
              <p 
                dangerouslySetInnerHTML={{ __html: data.description }}
                className="font-light text-center text-white/50 text-sm w-[16rem]"
              ></p>
            </header>

            <section className="flex gap-2 h-[2.7rem]">
              <button 
                  onClick={() => {
                      data.callback()
                      setPopup(false)
                  }}
                  className={cn(
                      "w-full h-full rounded bg-gradient-primary", 
                      "text-white text-sm",  
                      "active:scale-95 hover:opacity-80 transition-all duration-200"
                  )}
              >
                  SIM
              </button>
              <button 
                  onClick={() => {
                      setPopup(false)
                  }}
                  className={cn(
                      "w-full h-full rounded bg-white/10", 
                      "border-solid border-[1px] border-white/10",
                      "font-bold text-white/50 text-sm",  
                      "active:scale-95 hover:opacity-80 transition-all duration-200"
                  )}
              >
                  NÃO
              </button>          
            </section>
          </>}
        </div>
      </div>
    </AnimationProvider>
  )
}