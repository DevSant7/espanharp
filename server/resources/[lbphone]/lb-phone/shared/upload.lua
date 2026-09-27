UploadMethods = {

    Custom = {

        Video = {

            url = "https://your-custom-url.com/upload?api=API_KEY",

            field = "file",
            headers = {
                ["Authorization"] = "Key API_KEY"

            },

            error = {

                path = "success",
                value = false
            },

            success = {

                path = "url"
            },

            suffix = "webm",
        },

        Image = {

            url = "https://your-custom-url.com/upload?api=API_KEY",

            field = "file",
            headers = {
                ["Authorization"] = "Key API_KEY"

            },

            error = {

                path = "success",
                value = false
            },

            success = {

                path = "url"
            },

            suffix = "png",
        },

        Audio = {

            url = "https://your-custom-url.com/upload?api=API_KEY",

            field = "file",
            headers = {
                ["Authorization"] = "Key API_KEY"

            },

            error = {

                path = "success",
                value = false
            },

            success = {

                path = "url"
            },

            suffix = "mp3",
        },

    },

    Fivemanage = {

        Default = {

            url = "PRESIGNED_URL",

            field = "file",

            success = {

                path = "data.url"

            },

            sendPlayer = "metadata"

        },

    },

    LBUpload = {

        Default = {

            url = "http://82.40.22.113:30120/lb-upload/",

            field = "file",

            headers = {

                ["Authorization"] = "API_KEY"

            },

            error = {

                path = "success",

                value = false

            },

            success = {

                path = "link"

            },

            sendPlayer = "metadata"

        },

    },

    Fivemanage = {

        Video = {

            url = "https://api.fivemanage.com/api/v2/video",

            field = "file",

            headers = {

                ["Authorization"] = "Pf3KzEB447t9RKI3YjNqmED51dQEXBZq"

            },

            success = {

                path = "data.url"

            },

        },

        Image = {

            url = "https://api.fivemanage.com/api/v2/image",

            field = "file",

            headers = {

                ["Authorization"] = "xRUQBOXNy13SeLkhN7fyxwdyTGRJ0Ivn"

            },

            success = {

                path = "data.url"

            }

        },

        Audio = {

            url = "https://api.fivemanage.com/api/v2/audio",

            field = "file",

            headers = {

                ["Authorization"] = "4CPOLSiGM8pB0apDpuIi5uekfkdeuk6H"

            },

            success = {

                path = "data.url"

            }

        },

    },

}
