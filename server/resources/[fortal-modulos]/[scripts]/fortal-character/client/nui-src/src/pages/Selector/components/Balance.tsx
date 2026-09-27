import { useSelection } from "../stores/useSelection";
import { useCharacters } from "../stores/useCharacters";

export default function Balance() {
  const { current: selected } = useSelection();
  const { current: characters } = useCharacters();
  const character = characters[selected];

  return (
    (character && character.type === "character") &&
    <section className="absolute left-14 top-[3.19rem] flex flex-col items-start gap-4 overflow-visible">
      <p className="overflow-visible text-lg font-bold leading-none text-white/65">
        Detalhes da conta
      </p>
      <div className="flex items-center gap-[1.13rem] overflow-visible">
        <div className="flex items-center gap-3 overflow-visible">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            className="h-5"
            viewBox="0 0 24 20"
            fill="none"
          >
            <path
              d="M7.81348 1H16.1865C17.0977 1 17.96 1.41456 18.5293 2.12598L21.585 5.94336C22.2092 6.72369 22.1617 7.8456 21.4736 8.57031L12 18.5469L2.52637 8.57031C1.83829 7.8456 1.79082 6.72369 2.41504 5.94336L5.4707 2.12598C6.04003 1.41456 6.9023 1 7.81348 1Z"
              stroke="#df5454"
              strokeWidth="2"
            />
            <rect
              x="2.7372"
              y="6.11122"
              width="18.5253"
              height="1.11111"
              fill="white"
              stroke="#df5454"
              strokeWidth="1.11111"
            />
          </svg>
          <p className="overflow-visible text-base font-bold leading-none text-white">
            {character.gems.toLocaleString("pt-br", {
              maximumFractionDigits: 0,
            })}
          </p>
        </div>
        {character.vip && (
          <div className="flex items-center gap-3">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              className="h-[1.0625rem]"
              viewBox="0 0 22 17"
              fill="none"
            >
              <path
                d="M13.0977 7.60645C13.692 8.78706 15.1664 9.17241 16.2559 8.49609L16.4688 8.3457L19.3154 6.08105L17.7168 14.8223C17.5911 15.5025 16.9949 15.9999 16.2939 16H5.70605C5.00131 15.9999 4.40709 15.4991 4.28418 14.8252L4.2832 14.8242L2.68359 6.08105L5.53125 8.3457C6.63262 9.21971 8.26828 8.86591 8.90234 7.60645L11 3.4375L13.0977 7.60645ZM1.52734 3.42871C1.82526 3.42871 2.05559 3.66615 2.05566 3.94629C2.05566 4.05992 2.018 4.16657 1.9502 4.25684L1.79492 4.46387H1.52734C1.22959 4.46364 1 4.22635 1 3.94629C1.00008 3.66629 1.22964 3.42894 1.52734 3.42871ZM20.4727 3.42871C20.7704 3.42894 20.9999 3.66629 21 3.94629C21 4.22635 20.7704 4.46364 20.4727 4.46387H20.2051L20.0498 4.25684C19.982 4.16657 19.9443 4.05992 19.9443 3.94629C19.9444 3.66615 20.1747 3.42871 20.4727 3.42871ZM11 1C11.2979 1 11.5272 1.2375 11.5273 1.51758C11.5273 1.6978 11.4309 1.86277 11.2812 1.9541L11 2.125L10.7188 1.9541C10.5679 1.86202 10.4727 1.70021 10.4727 1.51758C10.4728 1.2375 10.7021 1 11 1Z"
                stroke="#E5A339"
                strokeWidth="2"
              />
            </svg>
            <p className="overflow-visible text-base font-bold leading-none text-white">
              {character.vip.title}
            </p>
            <div className="h-[2.125rem] rounded-[0.3125rem] border border-white/10 bg-[#E5A339] px-2">
              <p className="flex h-full items-center text-base font-bold leading-none text-white">
                {character.vip.remaining} Dias
              </p>
            </div>
          </div>
        )}
      </div>
    </section>
  );
}
