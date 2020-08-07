pragma solidity 0.4.25;

contract Eleccion {

    constructor () public {
        addCandidate("Jose Andres Lojano Carpio");
        addCandidate("Pedro Francisco Montero Rodriguez");
        addCandidate("Lucia Magdalena Valverde Romero");
    }

    // Candidato modelo
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Almacenar cuentas que han votado
    mapping(address => bool) public voters;
    // Almacenar Candidatis
    // Buscar candidato
    mapping(uint => Candidate) public candidates;
    // Cuenta de candidatos
    uint public candidatesCount;

    // evento de votacion
    event votedEvent (
        uint indexed _candidateId
    );

    
    function addCandidate (string _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }
    function vote (uint _candidateId) public {
        // requieren que no hayan votado antes
        require(!voters[msg.sender]);

        // requiere un candidato valido
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // registrar que el votante ha votado
        voters[msg.sender] = true;

        // actualizar conteo de voto
        candidates[_candidateId].voteCount ++;

        // trigger evento voto
        emit votedEvent(_candidateId);
    }
}
