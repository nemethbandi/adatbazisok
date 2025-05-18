{
    "metadata": {
        "kernelspec": {
            "name": "SQL",
            "display_name": "SQL",
            "language": "sql"
        },
        "language_info": {
            "name": "sql",
            "version": ""
        }
    },
    "nbformat_minor": 2,
    "nbformat": 4,
    "cells": [
        {
            "cell_type": "code",
            "source": [
                "-- Lekérdezi azt az oktatót, aki a legtöbb különböző tanulót vitt vizsgára.\r\n",
                "\r\n",
                "SELECT o.oktato_id, o.nev AS oktato_nev, COUNT(DISTINCT v.tanulo_id) AS vizsgaztatott_tanulok\r\n",
                "FROM vizsga v\r\n",
                "JOIN jelentkezes j ON v.tanulo_id = j.tanulo_id\r\n",
                "JOIN oktato o ON j.oktato_id = o.oktato_id\r\n",
                "GROUP BY o.oktato_id, o.nev\r\n",
                "ORDER BY vizsgaztatott_tanulok DESC\r\n",
                "LIMIT 1;"
            ],
            "metadata": {
                "azdata_cell_guid": "96822a2c-bacb-4b30-bf72-1cf21d507e9f",
                "language": "sql"
            },
            "outputs": [],
            "execution_count": null
        },
        {
            "cell_type": "code",
            "source": [
                "-- Hónaponként megszámolja, hány vizsga volt vizsgatípusonként, és csökkenő sorrendben mutatja a leggyakoribbakat.\r\n",
                "\r\n",
                "SELECT \r\n",
                "    MONTH(v.datum) AS honap,\r\n",
                "    v.tipus,\r\n",
                "    COUNT(*) AS darab\r\n",
                "FROM vizsga v\r\n",
                "GROUP BY honap, v.tipus\r\n",
                "ORDER BY honap, darab DESC;"
            ],
            "metadata": {
                "azdata_cell_guid": "e496002e-9bf1-483f-bbf4-3eae2c9a1160",
                "language": "sql"
            },
            "outputs": [],
            "execution_count": null
        },
        {
            "cell_type": "code",
            "source": [
                "-- Oktatónként listázza a hozzá tartozó tanulók nevét és elérhetőségeit (telefonszám, e-mail).\r\n",
                "\r\n",
                "SELECT \r\n",
                "    o.nev AS oktato_nev,\r\n",
                "    t.nev AS tanulo_nev,\r\n",
                "    t.telefonszam,\r\n",
                "    t.email\r\n",
                "FROM jelentkezes j\r\n",
                "JOIN oktato o ON j.oktato_id = o.oktato_id\r\n",
                "JOIN tanulo t ON j.tanulo_id = t.tanulo_id\r\n",
                "GROUP BY o.nev, t.nev, t.telefonszam, t.email\r\n",
                "ORDER BY o.nev, t.nev;\r\n",
                ""
            ],
            "metadata": {
                "azdata_cell_guid": "efe8546a-c6ee-4270-981d-627119561403",
                "language": "sql"
            },
            "outputs": [],
            "execution_count": null
        },
        {
            "cell_type": "code",
            "source": [
                "-- Lekérdezi azokat a tanulókat, akik még soha nem buktak el vizsgát.\r\n",
                "\r\n",
                "SELECT t.tanulo_id, t.nev\r\n",
                "FROM tanulo t\r\n",
                "WHERE t.tanulo_id NOT IN (\r\n",
                "    SELECT tanulo_id FROM vizsga WHERE eredmeny = 0\r\n",
                ");\r\n",
                ""
            ],
            "metadata": {
                "azdata_cell_guid": "32ecbb74-27e1-461c-994d-e82f259d8f83",
                "language": "sql"
            },
            "outputs": [],
            "execution_count": null
        },
        {
            "cell_type": "code",
            "source": [
                "-- Oktatónként kiszámolja az összes tanfolyami bevételt, az árak alapján összesítve.\r\n",
                "\r\n",
                "SELECT \r\n",
                "    v.tanulo_id,\r\n",
                "    t.nev AS tanulo_nev,\r\n",
                "    v.tipus,\r\n",
                "    COUNT(*) OVER(PARTITION BY v.tanulo_id) AS tanulo_osszes_vizsga\r\n",
                "FROM vizsga v\r\n",
                "JOIN tanulo t ON v.tanulo_id = t.tanulo_id;"
            ],
            "metadata": {
                "azdata_cell_guid": "463b7f1b-5e3e-4630-a737-812f54d2eb0e",
                "language": "sql"
            },
            "outputs": [],
            "execution_count": null
        }
    ]
}