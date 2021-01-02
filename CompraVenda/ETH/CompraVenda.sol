pragma solidity ^0.4.18;

contract CompraVenda {

  struct Article {
    uint id;
    address seller;
    address buyer;
    string name;
    string description;
    uint256 price;
  }

  mapping (uint => Article) public articles;
  uint articleCounter;

  //anunciar um item
  function sellArticle(string _name, string _description, uint256 _price) public {
    articleCounter++;

    articles[articleCounter] = Article(
      articleCounter,
      msg.sender,
      0x0,
      _name,
      _description,
      _price
    );
  }

  //quantidade de itens anunciados
  function getNumberOfArticles() public view returns (uint) {
    return articleCounter;
  }

  //retorna os itens ainda a venda
  function getArticlesForSale() public view returns (uint[]) {
    uint[] memory articleIds = new uint[](articleCounter);

    uint numberOfArticlesForSale = 0;
    for(uint i = 1; i <= articleCounter; i++) {
      if(articles[i].buyer == 0x0) { //se não tiver comprador
        articleIds[numberOfArticlesForSale] = articles[i].id;
        numberOfArticlesForSale++;
      }
    }

    //copia para array de itens
    uint[] memory forSale = new uint[](numberOfArticlesForSale);
    for(uint j = 0; j < numberOfArticlesForSale; j++) {
      forSale[j] = articleIds[j];
    }

    return forSale;
  }

  function getArticle(uint _id) public view returns (string, string, uint256) {
    //deve existir
    require(_id > 0 && _id <= articleCounter);

    Article storage article = articles[_id];

    return (article.name, article.description, article.price);
  }

  //comprar um item
  function buyArticle(uint _id) payable public {
    //deve ter itens a venda
    require(articleCounter > 0);

    //deve existir
    require(_id > 0 && _id <= articleCounter);

    Article storage article = articles[_id];

    //não foi vendido ainda
    require(article.buyer == 0X0);

    //não pode ser do próprio comprador
    require(msg.sender != article.seller);

    //valor enviado deve ser igual ao do valor anunciado
    require(msg.value == article.price);

    //atualiza comprador
    article.buyer = msg.sender;

    //paga vendedor
    article.seller.transfer(msg.value);
  }
}
