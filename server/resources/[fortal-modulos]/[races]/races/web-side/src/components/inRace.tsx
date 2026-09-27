import "./inRace.css"

import type React from "react"
import { useEffect, useState } from "react"

import { formatTime } from "../utils/formatTime"

interface IRanking {
  name: string
  id: number
  pos: number
  time: number
  vehicle: string
  position: number
  finished?: boolean
}

interface IMyProfile {
  name: string
  id: number
  pos: number
  time: number
  finished?: boolean
}

interface InfosRace {
  timeInRace: number
  checkpoint: number
  maxCheckpoint: number
  timeToExplode?: number
  myPos?: number
  maxPos?: number
  ranking?: IRanking[]
  myProfile?: IMyProfile
}

interface InRaceComponentProps {
  messageData: {
    values: InfosRace
  }
}

const InRaceComponent: React.FC<InRaceComponentProps> = ({ messageData }) => {
  const [time, setTime] = useState<string>("")

  const { timeInRace, checkpoint, maxCheckpoint, myPos, maxPos, myProfile, ranking } = messageData.values

  useEffect(() => {
    setTime(formatTime(timeInRace))
  }, [timeInRace])

  const FlagIcon = () => (
    <svg width="16" height="16" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M3 2V18H5V12H12L11 10H17V4H11L12 6H5V2H3Z" fill="#FFFFFF" />
    </svg>
  )

  const getDisplayRanking = (): IRanking[] => {
    if (!ranking || ranking.length === 0) {
      return myProfile ? [{ ...myProfile, position: myPos !== undefined ? myPos : myProfile.pos, vehicle: "Meu Veículo" }] : []
    }

    let displayList: IRanking[] = ranking.slice(0, 3)

    const myProfileIsInDisplayList = myProfile && displayList.some((player) => player.id === myProfile.id)

    if (myProfile && !myProfileIsInDisplayList) {
      const myRankedProfile: IRanking = {
        ...myProfile,
        position: myPos !== undefined ? myPos : myProfile.pos,
        vehicle: "Meu Veículo"
      }

      if (displayList.length < 4) {
        displayList.push(myRankedProfile);
      }
    }

    displayList.sort((a, b) => a.position - b.position);

    return displayList
  }

  const displayRanking = getDisplayRanking()

  return (
    <div className="inrace">
      {myPos !== undefined && maxPos !== undefined && (
        <>
          <div className="inrace-title">
            <svg width="20px" height="20px" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path
                d="M5.83333 15.8333H17.5V17.0833C17.5 18.6917 16.1917 20 14.5833 20H5.2C5.6 19.4033 5.83333 18.6867 5.83333 17.9167V15.8333ZM15.0125 8.21417L17.73 10.315L18.355 9.87917L17.25 6.52167L20 4.93083V4.16667H16.395L15.415 0.416667H14.6067L13.6258 4.16667H10.0008V4.93583L12.7692 6.47583L11.6833 9.8725L12.285 10.325L15.0142 8.215L15.0125 8.21417ZM8.81833 8.33333H3.33333V6.66667H8.385C8.35083 6.39333 8.33333 6.11583 8.33333 5.83333C8.33333 5.55083 8.35083 5.27333 8.385 5H3.33333V3.33333H8.81833C9.3925 1.915 10.4408 0.739167 11.7667 0.0025C11.7333 0.000833333 11.7 0 11.6667 0H2.5C1.11917 0 0 1.11917 0 2.5V17.7975C0 18.8875 0.784167 19.8808 1.86833 19.9892C3.115 20.1142 4.16667 19.1383 4.16667 17.9167V14.1667H14.1667V12.4483C11.7333 12.145 9.7075 10.53 8.81833 8.33333ZM7.5 11.6667H3.33333V10H7.5V11.6667Z"
                fill="white"
              />
              <path
                d="M5.83333 15.8333H17.5V17.0833C17.5 18.6917 16.1917 20 14.5833 20H5.2C5.6 19.4033 5.83333 18.6867 5.83333 17.9167V15.8333ZM15.0125 8.21417L17.73 10.315L18.355 9.87917L17.25 6.52167L20 4.93083V4.16667H16.395L15.415 0.416667H14.6067L13.6258 4.16667H10.0008V4.93583L12.7692 6.47583L11.6833 9.8725L12.285 10.325L15.0142 8.215L15.0125 8.21417ZM8.81833 8.33333H3.33333V6.66667H8.385C8.35083 6.39333 8.33333 6.11583 8.33333 5.83333C8.33333 5.55083 8.35083 5.27333 8.385 5H3.33333V3.33333H8.81833C9.3925 1.915 10.4408 0.739167 11.7667 0.0025C11.7333 0.000833333 11.7 0 11.6667 0H2.5C1.11917 0 0 1.11917 0 2.5V17.7975C0 18.8875 0.784167 19.8808 1.86833 19.9892C3.115 20.1142 4.16667 19.1383 4.16667 17.9167V14.1667H14.1667V12.4483C11.7333 12.145 9.7075 10.53 8.81833 8.33333ZM7.5 11.6667H3.33333V10H7.5V11.6667Z"
                fill="url(#paint0_radial_875_2)"
                fillOpacity="0.25"
              />
              <defs>
                <radialGradient
                  id="paint0_radial_875_2"
                  cx="0"
                  cy="0"
                  r="1"
                  gradientUnits="userSpaceOnUse"
                  gradientTransform="translate(9.96865 15.3333) scale(12.0063 19.0941)"
                >
                  <stop stopColor="white" />
                  <stop offset="1" stopColor="white" stopOpacity="0" />
                </radialGradient>
              </defs>
            </svg>
            <h1>Sua classificação</h1>
          </div>
          <div className="inrace-pos">
            <div className="inrace-icon">
              <h1>{myPos}</h1>
            </div>
            <p>
              /<span>{maxPos}</span>
            </p>
          </div>
        </>
      )}

      <div className="inrace-info">
        <div className="inrace-time">
          <svg width="17px" height="17px" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path
              d="M10 18C12.1217 18 14.1566 17.1571 15.6569 15.6569C17.1571 14.1566 18 12.1217 18 10C18 7.87827 17.1571 5.84344 15.6569 4.34315C14.1566 2.84285 12.1217 2 10 2C7.87827 2 5.84344 2.84285 4.34315 4.34315C2.84285 5.84344 2 7.87827 2 10C2 12.1217 2.84285 14.1566 4.34315 15.6569C5.84344 17.1571 7.87827 18 10 18ZM10 0C11.3132 0 12.6136 0.258658 13.8268 0.761205C15.0401 1.26375 16.1425 2.00035 17.0711 2.92893C17.9997 3.85752 18.7362 4.95991 19.2388 6.17317C19.7413 7.38642 20 8.68678 20 10C20 12.6522 18.9464 15.1957 17.0711 17.0711C15.1957 18.9464 12.6522 20 10 20C4.47 20 0 15.5 0 10C0 7.34784 1.05357 4.8043 2.92893 2.92893C4.8043 1.05357 7.34784 0 10 0ZM10.5 5V10.25L15 12.92L14.25 14.15L9 11V5H10.5Z"
              fill="white"
            />
          </svg>
          <h1>{time}</h1>
        </div>
        <div className="inrace-time">
          <svg width="17" height="18" viewBox="0 0 11 15" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path
              d="M2.99303 1.58221C3.006 1.51655 3.00565 1.44896 2.992 1.38343C2.97836 1.31791 2.9517 1.25579 2.91361 1.20076C2.87551 1.14573 2.82676 1.09891 2.77023 1.06307C2.71371 1.02723 2.65056 1.00311 2.58454 0.992128C2.51852 0.981146 2.45096 0.983532 2.38588 0.999143C2.3208 1.01475 2.25951 1.04327 2.20565 1.08301C2.1518 1.12274 2.10647 1.17289 2.07235 1.23047C2.03823 1.28805 2.01602 1.35189 2.00703 1.41821L0.00703059 13.4182C-0.00593523 13.4839 -0.00558639 13.5515 0.00805627 13.617C0.0216989 13.6825 0.0483578 13.7446 0.0864526 13.7997C0.124547 13.8547 0.173303 13.9015 0.229828 13.9374C0.286354 13.9732 0.349499 13.9973 0.415521 14.0083C0.481543 14.0193 0.549098 14.0169 0.614181 14.0013C0.679264 13.9857 0.740551 13.9572 0.794408 13.9174C0.848265 13.8777 0.893596 13.8275 0.927714 13.77C0.961833 13.7124 0.984044 13.6485 0.993031 13.5822L1.66303 9.56221C2.46903 9.68021 3.34003 9.71921 4.02603 10.2002C4.45046 10.5052 4.94127 10.705 5.45803 10.7832C6.42403 10.9292 7.28803 10.3982 8.24203 10.5492L9.53103 10.7432C9.79103 10.7832 10.061 10.5832 10.1 10.3232L10.984 4.38921L10.988 4.38521C11.0011 4.25468 10.9644 4.12401 10.8852 4.01942C10.806 3.91482 10.6902 3.84402 10.561 3.82121L9.27203 3.62721C8.30903 3.48421 7.44303 4.00021 6.48903 3.85721C6.06116 3.79224 5.65417 3.62896 5.30003 3.38021C4.56103 2.86321 3.68103 2.77721 2.81403 2.65521L2.99303 1.58221ZM2.40303 5.12021L2.73303 3.14821C3.33203 3.23021 3.96603 3.27721 4.52103 3.51721L4.22603 5.48221C3.65603 5.24921 3.01203 5.20421 2.40303 5.12021ZM1.74603 9.07021L2.07603 7.09621C2.69603 7.18221 3.35303 7.22621 3.93403 7.46421L4.23403 5.48821C4.89203 5.75821 5.39303 6.22121 6.12703 6.32921L6.42703 4.34921C7.16503 4.46021 7.77603 4.17221 8.48503 4.11521L8.18503 6.08121C7.47503 6.14121 6.86103 6.44121 6.12503 6.33121L5.83903 8.30921C5.10303 8.19921 4.60103 7.73421 3.94003 7.46521L3.64003 9.44121C3.04503 9.20221 2.37703 9.16021 1.74603 9.07021ZM5.84003 8.31021C6.57403 8.42021 7.19103 8.11821 7.90103 8.05921L8.18503 6.08121C8.84003 6.02121 9.51003 6.19221 10.153 6.29021L9.87303 8.26621C9.22903 8.16921 8.55703 7.99721 7.90203 8.05921L7.60203 10.0352C6.89303 10.0832 6.26703 10.3952 5.54003 10.2852L5.84003 8.31021Z"
              fill="white"
            />
          </svg>
          <h1>
            {checkpoint}
            <span>/</span>
            {maxCheckpoint}
          </h1>
        </div>
      </div>

      <div className="inrace-placement">
        {displayRanking.length > 0 ? (
          displayRanking.map((data) => (
            <div className="placement" key={data.id}>
              <div className={myProfile && data.id === myProfile.id ? "placement-myuser" : "placement-user"}>
                <div className="placement-colum">
                  <div
                    className={`${
                      data.finished
                        ? "placement-finished"
                        : data.position === 1
                        ? "placement-pos"
                        : data.position === 2
                        ? "placement-pos2"
                        : data.position === 3
                        ? "placement-pos3"
                        : "placement-pos-other"
                    }`}
                  >
                    {data.finished ? <FlagIcon /> : <h1>{data.position}</h1>}
                  </div>
                  <h1>{data.name}</h1>
                </div>
                <div className="placement-id">
                  <h1>#{data.id}</h1>
                </div>
              </div>
              <div className={myProfile && data.id === myProfile.id ? "placement-mytime" : "placement-time"}>
                <h1>{formatTime(data.time)}</h1>
              </div>
            </div>
          ))
        ) : (
          <p>Nenhum dado de ranking disponível.</p>
        )}
      </div>
    </div>
  )
}

export { InRaceComponent }