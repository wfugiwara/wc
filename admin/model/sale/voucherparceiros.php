<?php
class ModelSaleVoucherParceiros extends Model {

	public function Cupons($data = array()) {
		$sql = "SELECT * FROM `voucher_locais` AS a,`voucher_cupons` AS b,`voucher_parceiros` AS c,`" . DB_PREFIX . "customer` AS d WHERE a.idL=b.idEnd AND b.idPar=c.idPar AND d.customer_id=b.idCli ORDER BY b.dataCupon DESC";
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}
			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function Enderecos($data = array()) {
		$sql = "SELECT * FROM `voucher_locais` ORDER BY idPar ASC";
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}
			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}
	
	public function editarends($id,$par,$end) {
      	$query = $this->db->query("UPDATE `voucher_locais` SET  `idPar` =  '".$par."',
`det` =  '".$end."' WHERE `idL` ='".$id."';");
		return true;
	}
	
	public function addends($par,$end) {
      	$query = $this->db->query("INSERT INTO `voucher_locais` (`idL`, `idPar`, `det`) VALUES (NULL, '".$par."', '".$end."');");
		return true;
	}
	
	public function removerends($id) {
      	$query = $this->db->query("DELETE FROM `voucher_locais` WHERE idL = '".(int)$id."'");
		return true;
	}
	
	public function removerprod($id) {
      	$query = $this->db->query("DELETE FROM `voucher_produtos` WHERE idPv = '".(int)$id."'");
		return true;
	}
	
	public function GetParceiro($id){
		$query = $this->db->query("SELECT * FROM `voucher_parceiros` WHERE idPar = '".(int)$id."'");
		return $query->row;	
	}

	public function Parceiros($data = array()) {
		$sql = "SELECT * FROM `voucher_parceiros` ORDER BY nomePar ASC";
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}
			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}
	
	public function editarParceiro($nome,$logo,$categoria,$end,$valor,$id) {
      	$query = $this->db->query("UPDATE `voucher_parceiros` SET  `nomePar` =  '".$nome."',
`imagemPar` =  '".$logo."',
`valVoucher` =  '".$valor."',
`enderecoPar` =  '".$end."',
`catPar` =  '".$categoria."' WHERE `idPar` ='".$id."';");
		return true;
	}
	
	public function addParceiro($nome,$logo,$categoria,$end,$valor) {
      	$query = $this->db->query("INSERT INTO `voucher_parceiros` (`idPar`, `nomePar`, `imagemPar`, `valVoucher`, `enderecoPar`, `catPar`) VALUES (NULL, '".$nome."', '".$logo."', '".$valor."', '".$end."', '".$categoria."');");
		return true;
	}
	
	public function addProduto($prod) {
      	$query = $this->db->query("INSERT INTO `voucher_produtos` (`idPv`, `idProd`) VALUES (NULL, '".$prod."');");
		return true;
	}
	
	public function removerParceiro($id) {
      	$query = $this->db->query("DELETE FROM `voucher_parceiros` WHERE idPar = '".(int)$id."'");
		return true;
	}	
	

	public function Categorias($data = array()) {
		$sql = "SELECT * FROM `voucher_categorias` ORDER BY nomeCat ASC";
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}
			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}
	
	public function getCategoria($id) {
      	$query = $this->db->query("SELECT * FROM `voucher_categorias` WHERE idCat = '".(int)$id."'");
		return $query->row;
	}
	
	public function editarCategoria($nome,$sub,$id) {
      	$query = $this->db->query("UPDATE `voucher_categorias` SET  `nomeCat` =  '".$nome."', `paiCat` =  '".$sub."' WHERE `idCat` ='".$id."';");
		return true;
	}
	
	public function addCategoria($nome,$sub) {
      	$query = $this->db->query("INSERT INTO `voucher_categorias` (`idCat`, `nomeCat`, `paiCat`) VALUES (NULL, '".$nome."', '".$sub."');");
		return true;
	}
	
	public function removerCategoria($id) {
      	$query = $this->db->query("DELETE FROM `voucher_categorias` WHERE idCat = '".(int)$id."'");
		return true;
	}
	
}
?>