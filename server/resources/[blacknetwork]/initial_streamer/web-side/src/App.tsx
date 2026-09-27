
import { Icon } from '@iconify/react';
import { useEffect, useState } from 'react';
import styled from 'styled-components';
import { fetchNui } from './utils/fetchNui';


const BodyInitial = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  position: relative;
  width: 100vw;
  height: 100vh;
  background: rgba(16, 16, 21, 0.98);
  overflow: hidden;
    &:before {
      position: absolute;
      content: "";
      background: #5763D0;
      filter: blur(314.5px);
      width: 585px;
      height: 323px;
      left: -209px;
      top: -133px;
    }
    &:after {
      position: absolute;
      content: "";
      width: 180px;
      height: 345px;
      right: 0px;
      bottom: 0px;

      filter: blur(314.5px);
      transform: rotate(-31.48deg);
    }

  .flex {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    transform: scale(0.8);
    flex: 1;
    height: 100%;
    margin: 3rem;
    gap: 2rem;
    .header {
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      flex: 1;
      height:auto;
      gap: 0.5rem;
      .title { 
        display: flex;
      justify-content: center;
      align-items: center;
      gap: 0.5rem;
        font-family: 'DM Sans';
        font-style: normal;
        font-weight: 700;
        font-size: 17px;
        line-height: 130%;
        color: #FFFFFF;
    
      }
      .paragraph{
        font-family: 'DM Sans';
        font-style: normal;
        font-weight: 500;
        font-size: 16px;
        line-height: 130%;
        color: rgba(255, 255, 255, 0.35);
      }
    }
    main {
      display: flex;
      justify-content: center;
      align-items: center;
      width: 100vw;
      height: 100vh;
      flex-wrap: wrap;
     
      ul {
        display: flex;
        justify-content: center;
        align-items: center;
        list-style: none;
        flex-wrap: wrap;
       
        padding: 1rem;
        gap: 3rem;
        li {
          display: flex;
          flex-direction: column;
          transition: all 0.5s ;
          .card {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            width: 295px;
            background: rgba(16, 16, 21, 0.98);
            height: 100%;
          
            header {
              display: flex;
              justify-content: start;
              align-items: start;
              flex-direction: column;
              padding: 2rem;
              width: 100%;
              span {
                font-family: 'DM Sans';
                font-style: normal;
                font-weight: 500;
                font-size: 16px;
                color: rgba(255, 255, 255, 0.65);
              }

              h1 {
                font-family: 'DM Sans';
                  font-style: normal;
                  font-weight: 700;
                  font-size: 24px;
                  color: #FFFFFF;
              }
            }
            .main {
              transition: all 1s ;
          
              width: 100%;
              height: 100%;
              overflow: hidden;

              div {
                width: 100%;
                height: 100%;
                overflow: hidden;
                img {
                  transition: all 1s ;
                  width: 100%;
                  height: 100%;
             
                }
              }
            }
          }
          footer{
            display: flex;
            justify-content: center;
            align-items: center;
            transition: all 1s ;
            width: 100%;
            height: 65px;
            transform: scale(1);
            background: #5763D0;
            border-radius: 6px;
            font-family: 'DM Sans';
            font-style: normal;
            font-weight: 500;
            font-size: 18px;
            cursor: pointer;
            color: #FFFFFF;
          }
          &:hover {
            transition: all 1s ;
            transform: scale(1.2);
          }
        }
      }
    }
  }

`


interface cardsProps {
  id: number;
  name: string;
  subName: string;
  photo: string;
}


function App() {

  const [display, setDisplay] = useState<"flex" | "none">("none")
  const [cards, setCards] = useState<cardsProps[]>([]);


  const listener = ({ data }: { data: any }) => {

    if (data["cars"]) {
      setCards(data["cars"])
    }
    if (data["open"]) {
      setDisplay("flex")
    }

  }

  useEffect(() => {
    window.addEventListener("message", listener)

    return () => window.removeEventListener("message", listener)

  }, [])


  const handleSubmit = (index: number) => {
    const carsSelected = cards[index]?.name;

    fetchNui("Save", {
      Name: carsSelected,
    })
    setDisplay("none")
  }

  return (
    <BodyInitial style={{ display: display }}>
      <div className="flex">
        <header className='header'>
          <div className="title">
            ESCOLHA UM VEÍCULO INICIAL <Icon icon="ic:round-directions-car" color='#5763D0' />
          </div>
          <div className="paragraph">
            <p>Escolha seu primeiro veículo com sabedoria, você só tem apenas uma escolha.</p>
          </div>
        </header>
        <main>
          <ul>
            { cards && cards.length > 0 && cards.map((cards: any, index: any) => (

                <li key={index}>

                  <div className="card">
                    <header>
                      <span>
                        {cards.name}
                      </span>
                      <h1>{cards.subName}</h1>
                    </header>
                    <main className='main'>
                      <div>
                        <img src={`https://cdn.blacknetwork.com.br/conce/${cards.photo}.png`} alt="" />
                      </div>
                    </main>
                  </div>
                  <footer onClick={() => handleSubmit(index)}>
                    Escolher Veiculo
                  </footer>
                </li>
              ))
            }
          </ul>
        </main>
      </div>
    </BodyInitial>
  )
}

export default App
