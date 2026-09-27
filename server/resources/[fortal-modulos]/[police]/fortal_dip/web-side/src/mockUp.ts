import { IAnnounce, IPlayer, IPlayerSearch, ISelectedStatistics } from "./types";

export const playersSearchMockup: IPlayerSearch[] = [
  {
    name: "Felipe Lima",
    passport: "1",
    photo: "https://cdn.discordapp.com/attachments/941363423818678353/1104210611061149697/image.png",
    register: "Limpo",
    wanted: "Não",
    years: 25,
    size: "Não",
    history: [
      {
        type: "Multa",
        date: "15/06/2025",
        name: "João Silva",
        id: 123,
        description: "Excesso de velocidade",
        time: 2500
      },
      {
        type: "Prisão",
        date: "10/06/2025",
        name: "Maria Santos",
        id: 456,
        description: "Roubo a mão armada",
        time: 60
      }
    ]
  },
  {
    name: "Isabela Costa",
    passport: "2",
    register: "Limpo",
    wanted: "Não",
    years: 28,
    size: "Não",
    history: [
      {
        type: "Multa",
        date: "12/06/2025",
        name: "Carlos Oliveira",
        id: 789,
        description: "Estacionamento irregular",
        time: 500
      }
    ]
  },
  {
    name: "Lucas Oliveira",
    passport: "3",
    register: "Limpo",
    wanted: "Não",
    years: 30,
    size: "Não",
    history: []
  },
  {
    name: "Camila Santos",
    passport: "4",
    register: "Limpo",
    wanted: "Não",
    years: 22,
    size: "Não",
    history: [
      {
        type: "Prisão",
        date: "08/06/2025",
        name: "Pedro Almeida",
        id: 321,
        description: "Tráfico de drogas",
        time: 120
      }
    ]
  },
  {
    name: "Pedro Rodrigues",
    passport: "5",
    register: "Limpo",
    wanted: "Não",
    years: 35,
    size: "Não",
    history: [
      {
        type: "Multa",
        date: "20/06/2025",
        name: "Ana Costa",
        id: 654,
        description: "Dirigir sem habilitação",
        time: 1500
      },
      {
        type: "Multa",
        date: "18/06/2025",
        name: "Roberto Lima",
        id: 987,
        description: "Ultrapassagem perigosa",
        time: 800
      },
      {
        type: "Prisão",
        date: "15/06/2025",
        name: "Fernanda Silva",
        id: 147,
        description: "Posse ilegal de arma",
        time: 90
      }
    ]
  },
  {
    name: "Juliana Almeida",
    passport: "6",
    register: "Limpo",
    wanted: "Não",
    years: 26,
    size: "Não",
    history: []
  },
  {
    name: "Rafael Souza",
    passport: "7",
    register: "Limpo",
    wanted: "Não",
    years: 29,
    size: "Não",
    history: [
      {
        type: "Multa",
        date: "22/06/2025",
        name: "Lucas Mendes",
        id: 258,
        description: "Não usar cinto de segurança",
        time: 300
      }
    ]
  },
  {
    name: "Mariana Silva",
    passport: "8",
    register: "Limpo",
    wanted: "Não",
    years: 24,
    size: "Não",
    history: []
  },
  {
    name: "Gustavo Pereira",
    passport: "9",
    register: "Limpo",
    wanted: "Não",
    years: 31,
    size: "Não",
    history: [
      {
        type: "Prisão",
        date: "25/06/2025",
        name: "Diego Santos",
        id: 369,
        description: "Assalto a banco",
        time: 180
      }
    ]
  },
  {
    name: "Ana Oliveira",
    passport: "10",
    register: "Limpo",
    wanted: "Não",
    years: 27,
    size: "Não",
    history: []
  }
];

export const playersMockup: IPlayer[] = [
  {
    name: "Felipe Lima",
    passport: "1",
    photo:
      "https://cdn.discordapp.com/attachments/941363423818678353/1104210611061149697/image.png",
  },
  {
    name: "Isabela Costa",
    passport: "2",
  },
  {
    name: "Lucas Oliveira",
    passport: "3",
  },
  {
    name: "Camila Santos",
    passport: "4",
  },
  {
    name: "Pedro Rodrigues",
    passport: "5",
  },
  {
    name: "Juliana Almeida",
    passport: "6",
  },
  {
    name: "Rafael Souza",
    passport: "7",
  },
  {
    name: "Mariana Silva",
    passport: "8",
  },
  {
    name: "Gustavo Pereira",
    passport: "9",
  },
  {
    name: "Ana Oliveira",
    passport: "10",
  },
  {
    name: "Thiago Santos",
    passport: "11",
  },
  {
    name: "Fernanda Costa",
    passport: "12",
  },
  {
    name: "Bruno Alves",
    passport: "13",
    photo:
      "https://cdn.discordapp.com/attachments/941363423818678353/1104203632787853332/image.png",
  },
  {
    name: "Bianca Rodrigues",
    passport: "14",
  },
  {
    name: "José Silva",
    passport: "15",
  },
  {
    name: "Carla Oliveira",
    passport: "16",
    photo:
      "https://cdn.discordapp.com/attachments/941363423818678353/1101302980667514902/image.png",
  },
  {
    name: "Matheus Almeida",
    passport: "17",
  },
  {
    name: "Letícia Souza",
    passport: "18",
  },
  {
    name: "Vinícius Costa",
    passport: "19",
  },
  {
    name: "Amanda Pereira",
    passport: "20",
  },
  {
    name: "Pedro Henrique",
    passport: "21",
  },
  {
    name: "Júlia Santos",
    passport: "22",
  },
  {
    name: "Ricardo Silva",
    passport: "23",
  },
  {
    name: "Laura Oliveira",
    passport: "24",
  },
  {
    name: "Diego Alves",
    passport: "25",
  },
  {
    name: "Ana Carolina",
    passport: "26",
  },
  {
    name: "Luciana Souza",
    passport: "27",
  },
  {
    name: "Felipe Costa",
    passport: "28",
  },
  {
    name: "Vitória Rodrigues",
    passport: "29",
  },
  {
    name: "Gustavo Santos",
    passport: "30",
  },
  {
    name: "Mariana Almeida",
    passport: "31",
  },
  {
    name: "Thiago Oliveira",
    passport: "32",
  },
  {
    name: "Camila Silva",
    passport: "33",
  },
  {
    name: "Rafaela Pereira",
    passport: "34",
  },
  {
    name: "Lucas Souza",
    passport: "35",
  },
  {
    name: "Felipe Santos",
    passport: "36",
  },
  {
    name: "Felipe Almeida",
    passport: "37",
  },
  {
    name: "Felipe Oliveira",
    passport: "38",
  },
  {
    name: "Felipe Rodrigues",
    passport: "39",
  },
  {
    name: "Felipe Costa",
    passport: "40",
  },
  {
    name: "Felipe Silva",
    passport: "41",
  },
  {
    name: "Felipe Pereira",
    passport: "42",
  },
  {
    name: "Felipe Souza",
    passport: "43",
  },
  {
    name: "Felipe Martins",
    passport: "44",
  },
  {
    name: "Isabela Lima",
    passport: "45",
  },
  {
    name: "Isabela Santos",
    passport: "46",
  },
  {
    name: "Isabela Almeida",
    passport: "47",
  },
  {
    name: "Isabela Oliveira",
    passport: "48",
  },
  {
    name: "Isabela Rodrigues",
    passport: "49",
  },
  {
    name: "Isabela Costa",
    passport: "50",
  },
  {
    name: "Isabela Silva",
    passport: "51",
  },
  {
    name: "Isabela Pereira",
    passport: "52",
  },
  {
    name: "Isabela Souza",
    passport: "53",
  },
  {
    name: "Isabela Martins",
    passport: "54",
  },
  {
    name: "Lucas Lima",
    passport: "55",
  },
  {
    name: "Lucas Santos",
    passport: "56",
  },
  {
    name: "Lucas Almeida",
    passport: "57",
  },
  {
    name: "Lucas Oliveira",
    passport: "58",
  },
  {
    name: "Lucas Rodrigues",
    passport: "59",
  },
  {
    name: "Lucas Costa",
    passport: "60",
  },
  {
    name: "Lucas Silva",
    passport: "61",
  },
  {
    name: "Lucas Pereira",
    passport: "62",
  },
  {
    name: "Lucas Souza",
    passport: "63",
  },
  {
    name: "Lucas Martins",
    passport: "64",
  },
  {
    name: "Camila Lima",
    passport: "65",
  },
  {
    name: "Camila Santos",
    passport: "66",
  },
  {
    name: "Camila Almeida",
    passport: "67",
  },
  {
    name: "Camila Oliveira",
    passport: "68",
  },
  {
    name: "Camila Rodrigues",
    passport: "69",
  },
  {
    name: "Camila Costa",
    passport: "70",
  },
];

export const warnsMockup: IAnnounce[] = [
  {
    id: "88bd0bb1-1068-11ee-aeb5-0c9d928e7baa",
    title: "REUNIÃO HOJE ÁS 19:00!",
    description:
      "o doutor wilson pereirinha da silva sauro é o mais novo comandante dessa corporação velha suja e imunda, quem nao respeitar ele irá tomar muitas advertencias e até exoneração!",
    createdAt: "2023-05-11T15:39:01Z",
  },
  {
    id: "88bd0bb1-1068-11ee-aeb5-0c9d928e7baa",
    title: "REUNIÃO HOJE ÁS 19:00!",
    description:
      "o doutor wilson pereirinha da silva sauro é o mais novo comandante dessa corporação velha suja e imunda, quem nao respeitar ele irá tomar muitas advertencias e até exoneração!",
    createdAt: "2023-05-11T15:39:01Z",
  },
  {
    id: "88bd0bb1-1068-11ee-aeb5-0c9d928e7baa",
    title: "REUNIÃO HOJE ÁS 19:00!",
    description:
      "o doutor wilson pereirinha da silva sauro é o mais novo comandante dessa corporação velha suja e imunda, quem nao respeitar ele irá tomar muitas advertencias e até exoneração!",
    createdAt: "2023-05-11T15:39:01Z",
  },
  {
    id: "88bd0bb1-1068-11ee-aeb5-0c9d928e7baa",
    title: "REUNIÃO HOJE ÁS 19:00!",
    description:
      "o doutor wilson pereirinha da silva sauro é o mais novo comandante dessa corporação velha suja e imunda, quem nao respeitar ele irá tomar muitas advertencias e até exoneração! ",
    createdAt: "2023-05-11T15:39:01Z",
  },
];

export const statisticsMockupDate: ISelectedStatistics[] = [
  {
    date: "2023-05-22T15:39:01Z",
    data: [
      {
        name: "Itens apreendidas",
        Valor: 98,
      },
      {
        name: "Veículos apreendidos",
        Valor: 76,
      },
      {
        name: "B.O’s registrados",
        Valor: 23,
      },
      {
        name: "Prisões realizadas",
        Valor: 45,
      },
      {
        name: "Multas aplicadas",
        Valor: 90,
      },
    ],
  },
  {
    date: "2023-05-10T15:39:01Z",
    data: [
      {
        name: "Itens apreendidas",
        Valor: 20,
      },
      {
        name: "Veículos apreendidos",
        Valor: 10,
      },
      {
        name: "B.O’s registrados",
        Valor: 50,
      },
      {
        name: "Prisões realizadas",
        Valor: 70,
      },
      {
        name: "Multas aplicadas",
        Valor: 0,
      },
    ],
  },
  {
    date: "2023-05-09T15:39:01Z",
    data: [
      {
        name: "Itens apreendidas",
        Valor: 100,
      },
      {
        name: "Veículos apreendidos",
        Valor: 8,
      },
      {
        name: "B.O’s registrados",
        Valor: 44,
      },
      {
        name: "Prisões realizadas",
        Valor: 22,
      },
      {
        name: "Multas aplicadas",
        Valor: 11,
      },
    ],
  },
  {
    date: "2023-05-08T15:39:01Z",
    data: [
      {
        name: "Itens apreendidas",
        Valor: 100,
      },
      {
        name: "Veículos apreendidos",
        Valor: 80,
      },
      {
        name: "B.O’s registrados",
        Valor: 100,
      },
      {
        name: "Prisões realizadas",
        Valor: 100,
      },
      {
        name: "Multas aplicadas",
        Valor: 120,
      },
    ],
  },
];

export const optionsMockup = {
  suspect: [
    {
      id: 237,
      name: "Rael Asimov",
    },
    {
      id: 23,
      name: "Rael Asimov",
    },
    {
      id: 543,
      name: "Rael Asimov",
    },
    {
      id: 756,
      name: "Rael Asimov",
    },
  ],
  infractions: [
    {
      art: 177,
      description: "Trata do Crime de Furto. (5 meses e $2.500)",
    },
    {
      art: 177,
      description: "Trata do Crime de Furto. (5 meses e $2.500)",
    },
    {
      art: 177,
      description: "Trata do Crime de Furto. (5 meses e $2.500)",
    },
    {
      art: 177,
      description: "Trata do Crime de Furto. (5 meses e $2.500)",
    },
  ],
};

export const optionsMockupOccurrence = {
  applicant: [
    {
      id: 237,
      name: "Rael Asimov",
    },
  ],
  suspects: [
    {
      id: 237,
      name: "Rael Asimov",
    },
  ],
};

export const membersMockup = [
  {
    id: 1,
    name: "Rael Asimov",
    charge: "Commander",
    date: "12/06/2025",
    status: true,
  },
  {
    id: 2,
    name: "Higor Rezende",
    charge: "Lieutenant",
    date: "12/06/2025",
    status: false,
  },
];

export const optionsMockupFine = {
  suspect: [
    {
      id: 4650,
      name: "Higor Rezende",
    },
    {
      id: 237,
      name: "Rael Asimov",
    },
    {
      id: 1002,
      name: "Steve Hamptom",
    },
  ],
  infractions: [
    {
      art: 177,
      description: "Trata do Crime de Furto. (5 meses e $2.500)",
    },
    {
      art: 155,
      description: "Trata do Crime de Furto. (5 meses e $2.500)",
    },
  ],
};

export const wantedUserMockup = [
  {
    name: "Rael Asimov",
    date: "12/06/2025",
    description:
      "Suspeito de envolvimento em atividades criminosas, procurado por furto e posse ilegal de arma.",
    lastSeen: "12/06/2025",
    location: "Rua das Flores, Centro",
  },
  {
    name: "Higor Rezende",
    date: "12/06/2025",
    description:
      "Procurado por roubo a mão armada e agressão a autoridade.",
    lastSeen: "12/06/2025",
    location: "Avenida Brasil, Bairro Alto",
  },
  {
    name: "Higor Rezende",
    date: "12/06/2025",
    description:
      "Procurado por roubo a mão armada e agressão a autoridade.",
    lastSeen: "12/06/2025",
    location: "Avenida Brasil, Bairro Alto",
  },
];

export const occurrencesMockup = [
  {
    id: 1,
    date: "05/06/2025",
    officer: {
      id: 237,
      name: "Rael Asimov",
    },
    description: "Roubo ou furto de veículo na Avenida Brasil.",
    status: false,
  },
  {
    id: 2,
    date: "06/06/2025",
    officer: {
      id: 4650,
      name: "Higor Rezende",
    },
    description: "Suspeita de tráfico de drogas na Rua das Flores.",
    status: true,
  },
];

export const wantedVehicleMockup = [
  {
    model: "Ford Mustang",
    specifications: "Placa: ABC1234, Cor: Vermelho, Ano: 2020",
    lastSeen: "12/06/2025",
    location: "Rua Principal, Centro",
    date: "12/06/2025",
  },
  {
    model: "Chevrolet Camaro",
    specifications: "Placa: XYZ5678, Cor: Preto, Ano: 2019",
    lastSeen: "12/06/2025",
    location: "Avenida das Flores, Jardim",
    date: "12/06/2025",
  },
  {
    model: "Chevrolet Camaro",
    specifications: "Placa: XYZ5678, Cor: Preto, Ano: 2019",
    lastSeen: "12/06/2025",
    location: "Avenida das Flores, Jardim",
    date: "12/06/2025",
  },
];
