//define a linguagem e versão (0.4.18 >= versão < 1.5.0)
pragma solidity ^0.4.18;

contract Hello {
  string message;

  //construtor
  function Hello() public {
    message = "Valor inicial";
  }

  function setMessage(string msg) public {
    message = msg;
  }

  //"view": não altera o estado do contrato
  //não requer uma transação para chamar
  function getMessage() public view returns (string) {
    return message;
  }
}
