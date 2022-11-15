// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Prode {
    struct Partido {
        uint256 id;
        uint256 fechaPartido;
        uint256 golesA;
        uint256 golesB;
        uint256 pozo;
    }

    struct Apuesta {
        uint256 idApuesta;
        address apostador;
        uint256 idPartido;
        uint256 golesA;
        uint256 golesB;
        uint256 cantidad;
    }

    mapping(uint256 => Partido) public partidos;
    mapping(uint256 => Apuesta) public apuestas_id;

    uint256 public blockTimestamp = block.timestamp;
    uint256 public partidosJugados = 0;
    uint256 public apuestasRealizadas = 0;

    function crearPartido(uint256 _fechaPartido) public {
        Partido memory nuevoPartido = Partido(
            partidosJugados,
            _fechaPartido,
            0,
            0,
            0
        );
        partidos[_fechaPartido] = nuevoPartido;
        partidosJugados += 1;
    }

    function finalizarPartido(
        uint256 _id,
        uint256 _golesA,
        uint256 _golesB
    ) public {
        // require(block.timestamp >= _fechaPartido, "No podes finalizar este partido aun");
        partidos[_id].golesA = _golesA;
        partidos[_id].golesB = _golesB;
    }

    function leerPartido(uint256 _id) public view returns (uint256[2] memory) {
        uint256 miPartidoA = partidos[_id].golesA;
        uint256 miPartidoB = partidos[_id].golesB;
        return [miPartidoA, miPartidoB];
    }

    function apostar(
        uint256 _idPartido,
        uint256 _golesA,
        uint256 _golesB,
        uint256 _cantidad
    ) public {
        Apuesta memory nuevaApuesta = Apuesta(
            apuestasRealizadas,
            msg.sender,
            _idPartido,
            _golesA,
            _golesB,
            _cantidad
        );
        apuestas_id[apuestasRealizadas] = nuevaApuesta;
        partidos[_idPartido].pozo += _cantidad;
        apuestasRealizadas += 1;
    }

    function verPozo(uint256 _idPartido) public view returns (uint256) {
        return partidos[_idPartido].pozo;
    }

    function cobrarPremio(uint256 _idPartido, uint256 _idApuesta)
        public
        view
        returns (uint256)
    {
        require(
            apuestas_id[_idApuesta].apostador == msg.sender,
            "Apostador incorrecto"
        );
        if (partidos[_idPartido].golesA == apuestas_id[_idApuesta].golesA) {
            if (partidos[_idPartido].golesB == apuestas_id[_idApuesta].golesB) {
                return partidos[_idPartido].pozo;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    }
}
