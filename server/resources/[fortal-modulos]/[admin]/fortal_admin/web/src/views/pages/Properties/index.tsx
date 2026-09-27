import * as motion from "motion/react-client";
import { debugData } from "@app/utils/debugData";

import { Separator } from "@views/components/ui/separator";
import { useState } from "react";
import { useNuiEvent } from "@app/hooks/useNuiEvent";
import { Search } from "lucide-react";
import { Modal } from "@views/components/modal";

debugData([
  {
    action: "setProperties",
    data: {
      properties: [
        {
          id: 1,
          type: "Casa",
          name: "123 Ocean Drive, Miami, FL",
        },
        {
          id: 2,
          type: "Apartamento",
          name: "456 Park Avenue, New York, NY",
        },
        {
          id: 3,
          type: "Chácara",
          name: "789 Country Road, Springfield, IL",
        },
        {
          id: 4,
          type: "Cobertura",
          name: "101 Avenida Paulista, São Paulo, SP",
        },
        {
          id: 5,
          type: "Casa",
          name: "202 Mountain View, Boulder, CO",
        },
        {
          id: 6,
          type: "Flat",
          name: "303 Baker Street, London, UK",
        },
        {
          id: 7,
          type: "Apartamento",
          name: "404 Shibuya, Tokyo, JP",
        },
        {
          id: 8,
          type: "Casa",
          name: "505 Via Roma, Tuscany, IT",
        },
        {
          id: 9,
          type: "Villa",
          name: "606 Sunset Boulevard, Ibiza, ES",
        },
        {
          id: 10,
          type: "Penthouse",
          name: "707 Palm Jumeirah, Dubai, AE",
        },
        { id: 11, type: "Casa", name: "808 Queen Street, Auckland, NZ" },
        { id: 12, type: "Apartamento", name: "909 King Street, Toronto, CA" },
        { id: 13, type: "Chácara", name: "1001 Countryside Lane, Austin, TX" },
        {
          id: 14,
          type: "Casa",
          name: "123 Ocean Drive, Miami, FL",
        },
        {
          id: 15,
          type: "Apartamento",
          name: "456 Park Avenue, New York, NY",
        },
        {
          id: 16,
          type: "Chácara",
          name: "789 Country Road, Springfield, IL",
        },
      ],
    },
  },
]);

interface Properties {
  id: number;
  type: string;
  name: string;
}

export function Properties() {
  const [properties, setProperties] = useState<Properties[]>([]);
  const [searchProperty, setSearchProperty] = useState("");
  const [modalRemovePropertyOpen, setModalRemovePropertyOpen] = useState(false);
  const [selectedProperty, setSelectedProperty] = useState<Properties | null>(
    null
  );

  const filteredProperties = properties.filter((property) =>
    property.name.toLowerCase().includes(searchProperty.toLowerCase())
  );

  useNuiEvent("setProperties", (data) => {
    setProperties(data.properties);
  });

  return (
    <>
      <motion.div
        initial={{ opacity: 0, scale: 0 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{
          duration: 0.4,
          scale: { type: "spring", visualDuration: 0.4, bounce: 0.2 },
        }}
        className="w-[72rem] flex flex-col"
      >
        <h1 className="text-white text-xl font-bold mt-[1.31rem] ml-[1.56rem]">
          Propriedades
        </h1>
        <Separator className="w-full h-[0.0625rem] bg-[#FFFFFF08] mt-[1.2rem]" />

        <div className="relative w-[70rem] ml-[1.06rem] mt-4">
          <input
            type="text"
            placeholder="Buscar"
            value={searchProperty}
            onChange={(e) => setSearchProperty(e.target.value)}
            className="w-full h-[3.125rem] text-white/85 placeholder-white/50 border border-white/[.03] rounded-md px-4 pl-10 py-2 outline-none text-base"
            style={{
              background:
                "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
            }}
          />
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-[#FFFFFF59] w-5 h-5" />
        </div>

        <div className="mt-[.63rem] ml-[1.06rem] flex-wrap gap-[.63rem] flex max-h-[40rem] overflow-y-auto scrollbar-hide">
          {filteredProperties.map((property) => (
            <div
              key={property.id}
              className="w-[11.125rem] h-[14.0625rem] rounded-md border border-white/[.03] flex flex-col items-center justify-center hover:border-[#df545440]"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
              }}
            >
              <h2 className="text-white text-lg font-bold">{property.type}</h2>
              <p className="text-[#FFFFFF80] truncate max-w-[10rem]">
                {property.name}
              </p>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="7.125rem"
                height="7rem"
                viewBox="0 0 114 112"
                fill="none"
              >
                <g filter="url(#filter0_d_75_6774)">
                  <path
                    d="M54.7008 30.8684C55.9981 29.7105 58.0019 29.7105 59.2886 30.8684L68.8123 39.3701V38.1207C68.8123 36.3229 70.3204 34.8704 72.1872 34.8704H75.5621C77.4289 34.8704 78.937 36.3229 78.937 38.1207V48.4303L82.9237 51.9955C83.9362 52.9097 84.2737 54.3215 83.7674 55.5607C83.2612 56.7999 82.0167 57.6226 80.6245 57.6226H78.937V75.4994C78.937 79.0849 75.9102 82 72.1872 82H41.8128C38.0898 82 35.063 79.0849 35.063 75.4994V57.6226H33.3755C31.9833 57.6226 30.7388 56.7999 30.2326 55.5607C29.7263 54.3215 30.0638 52.8995 31.0763 51.9955L54.7008 30.8684ZM62.9061 55.9975C62.9061 52.8589 60.2589 50.3094 57 50.3094C53.7411 50.3094 51.0939 52.8589 51.0939 55.9975C51.0939 59.136 53.7411 61.6855 57 61.6855C60.2589 61.6855 62.9061 59.136 62.9061 55.9975ZM45.1877 73.8742C45.1877 74.768 45.9471 75.4994 46.8752 75.4994H67.1248C68.0529 75.4994 68.8123 74.768 68.8123 73.8742C68.8123 69.3847 65.0366 65.7484 60.3749 65.7484H53.6251C48.9634 65.7484 45.1877 69.3847 45.1877 73.8742Z"
                    fill="#df5454"
                  />
                </g>
                <defs>
                  <filter
                    id="filter0_d_75_6774"
                    x="0"
                    y="0"
                    width="114"
                    height="112"
                    filterUnits="userSpaceOnUse"
                    color-interpolation-filters="sRGB"
                  >
                    <feFlood flood-opacity="0" result="BackgroundImageFix" />
                    <feColorMatrix
                      in="SourceAlpha"
                      type="matrix"
                      values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                      result="hardAlpha"
                    />
                    <feOffset />
                    <feGaussianBlur stdDeviation="15" />
                    <feComposite in2="hardAlpha" operator="out" />
                    <feColorMatrix
                      type="matrix"
                      values="0 0 0 0 0.235294 0 0 0 0 0.556863 0 0 0 0 0.862745 0 0 0 0.4 0"
                    />
                    <feBlend
                      mode="normal"
                      in2="BackgroundImageFix"
                      result="effect1_dropShadow_75_6774"
                    />
                    <feBlend
                      mode="normal"
                      in="SourceGraphic"
                      in2="effect1_dropShadow_75_6774"
                      result="shape"
                    />
                  </filter>
                </defs>
              </svg>

              <button
                className="flex items-center justify-center w-[9.125rem] h-8 rounded border border-white/[.05] bg-white/[.01] hover:bg-[#df5454] text-white/35 text-sm font-bold hover:text-white cursor-pointer transition-all mt-1"
                onClick={() => {
                  setSelectedProperty(property);
                  setModalRemovePropertyOpen(true);
                }}
              >
                REMOVER
              </button>
            </div>
          ))}
        </div>
      </motion.div>
      <Modal
        open={modalRemovePropertyOpen}
        onClose={() => setModalRemovePropertyOpen(false)}
      >
        <div className="w-full p-6">
          <div className="flex items-center gap-3 mb-6">
            <div className="w-6 h-6 flex items-center justify-center">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="#df5454">
                <path d="M1 21h22L12 2 1 21zm12-3h-2v-2h2v2zm0-4h-2v-4h2v4z" />
              </svg>
            </div>
            <h2 className="text-white text-lg font-bold">
              Remover Propriedade
            </h2>
          </div>

          <div className="mb-8">
            <p className="text-white/60 text-sm leading-relaxed">
              Você tem certeza de que realmente quer prosseguir com isso?
            </p>
          </div>

          <div className="flex items-center gap-3">
            <button
              onClick={() => setModalRemovePropertyOpen(false)}
              className="flex-1 h-12 rounded-md bg-white/5 border border-white/10 text-white/60 font-medium hover:bg-white/10 transition-colors"
            >
              CANCELAR
            </button>
            <button
              onClick={() => {
                // Lógica para remover a propriedade
                console.log("Remover propriedade:", selectedProperty);
                setModalRemovePropertyOpen(false);
              }}
              className="flex-1 h-12 rounded-md bg-[#df5454] text-white font-bold hover:bg-[#3577C7] transition-colors"
            >
              DEFINIR
            </button>
          </div>
        </div>
      </Modal>
    </>
  );
}
