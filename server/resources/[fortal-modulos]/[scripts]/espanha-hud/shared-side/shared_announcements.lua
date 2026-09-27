hudConfig.announcePresets = {
    ["default"] = {
        color = "#EA3897",
        icon  = "fa-solid fa-bullhorn",
        title = "Alerta",
    },

    ["Policia Militar"] = {
        color = "#3B82F6",
        icon  = "fa-solid fa-shield-halved",
        title = "Alerta Policial",
    },
    ["Bope"] = {
        color = "#EF4444",
        icon  = "fa-solid fa-crosshairs",
        title = "Alerta BOPE",
    },
    ["Hospital"] = {
        color = "#10B981",
        icon  = "fa-solid fa-heart-pulse",
        title = "Alerta Hospitalar",
    },
    ["Restaurante"] = {
        color = "#F59E0B",
        icon  = "fa-solid fa-utensils",
        title = "Anúncio Restaurante",
    },
    ["Mecanica"] = {
        color = "#8B5CF6",
        icon  = "fa-solid fa-wrench",
        title = "Anúncio Mecânica",
    },
    ["Bombeiro"] = {
        color = "#F97316",
        icon  = "fa-solid fa-fire-extinguisher",
        title = "Alerta Bombeiro",
    },
    ["Europa"] = {
        color = "#EA3897",
        icon  = "fa-solid fa-star",
        title = "Anúncio Oficial",
    },
    ["Staff"] = {
        color = "#F43F5E",
        icon  = "fa-solid fa-user-shield",
        title = "Anúncio Staff",
    },
}

hudConfig.announceStaffPermission = "Dono"

hudConfig.announceTemplates = {
    ["Policia Militar"] = {
        {
            name    = "Recrutamento",
            message = "A Polícia Militar está com vagas abertas! Se você tem interesse em servir e proteger a cidade, procure o QG da PM para mais informações sobre o processo seletivo.",
        },
        {
            name    = "Blitz",
            message = "ATENÇÃO: Blitz policial em andamento. Todos os motoristas devem estar com documentos em dia. Colabore com a fiscalização.",
        },
        {
            name    = "Operação",
            message = "Operação policial em andamento na região. Evite a área e não interfira nos procedimentos policiais.",
        },
    },

    ["Bope"] = {
        {
            name    = "Recrutamento",
            message = "O BOPE está recrutando! Procuramos policiais experientes e dedicados. Apresente-se no QG do BOPE para avaliação.",
        },
        {
            name    = "Operação Especial",
            message = "Operação especial do BOPE em andamento. Área de risco isolada. Mantenham distância.",
        },
    },

    ["Hospital"] = {
        {
            name    = "Recrutamento",
            message = "O Hospital está contratando! Se você deseja salvar vidas e cuidar da saúde da população, procure o Hospital Central.",
        },
        {
            name    = "Atendimento",
            message = "O Hospital está em pleno funcionamento. Caso precise de atendimento médico, dirija-se ao Hospital Central.",
        },
        {
            name    = "Emergência",
            message = "EMERGÊNCIA MÉDICA: Equipes de resgate estão a postos. Em caso de urgência, ligue 192 ou procure a unidade mais próxima.",
        },
    },

    ["Restaurante"] = {
        {
            name    = "Recrutamento",
            message = "O Restaurante está contratando! Venha fazer parte da nossa equipe e ajude a alimentar a cidade.",
        },
        {
            name    = "Promoção",
            message = "PROMOÇÃO ESPECIAL! Venha conferir nosso cardápio com preços especiais. Esperamos você!",
        },
    },

    ["Mecanica"] = {
        {
            name    = "Recrutamento",
            message = "A Mecânica está contratando! Se você entende de veículos e quer trabalhar conosco, venha nos procurar.",
        },
        {
            name    = "Atendimento",
            message = "A Mecânica está aberta para atendimento! Traga seu veículo para reparos, customizações ou revisão.",
        },
    },

    ["Bombeiro"] = {
        {
            name    = "Recrutamento",
            message = "O Corpo de Bombeiros está com vagas abertas! Procuramos pessoas corajosas para proteger a cidade. Apresente-se no quartel.",
        },
        {
            name    = "Alerta de Incêndio",
            message = "ALERTA: Incêndio reportado na região. Equipes de combate a incêndio foram acionadas. Evite a área.",
        },
    },

    ["Europa"] = {
        {
            name    = "Manutenção",
            message = "AVISO: O servidor passará por manutenção em breve. Salve seus pertences e se prepare para uma breve desconexão.",
            style   = { icon = "fa-solid fa-gear", title = "Manutenção" },
        },
        {
            name    = "Evento",
            message = "EVENTO ESPECIAL acontecendo agora! Participe e ganhe prêmios exclusivos. Mais informações em breve.",
            style   = { icon = "fa-solid fa-calendar-star", title = "Evento Especial" },
        },
        {
            name    = "Atualização",
            message = "Nova atualização disponível! Confira as novidades e melhorias implementadas no servidor.",
            style   = { icon = "fa-solid fa-arrow-up-from-bracket", title = "Atualização" },
        },
    },
}

hudConfig.announceDepartments = {
    { group = "Admin",       level = 1, author = "Staff",            method = "HasGroup", isStaff = true },
    { group = "Policia",     level = 1, author = "Policia Militar",  method = "HasGroup"   },
    { group = "BOPE",        level = 1, author = "Bope",             method = "HasService"  },
    { group = "Paramedico",  level = 1, author = "Hospital",         method = "HasService"  },
    { group = "Restaurante", level = 1, author = "Restaurante",      method = "HasService"  },
    { group = "Mecanica",    level = 1, author = "Mecanica",         method = "HasService"  },
    { group = "Bombeiro",    level = 1, author = "Bombeiro",         method = "HasService"  },
}
