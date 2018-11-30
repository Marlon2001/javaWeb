<%@page import="br.senai.sp.model.Compromisso"%>
<%@page import="br.senai.sp.dao.CompromissoDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="br.senai.sp.model.Usuario"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<% 
	Usuario usuario = new Usuario();
	usuario = (Usuario) session.getAttribute("usuario");
	if (usuario == null){
		response.sendRedirect("login.html");
	}else{
		CompromissoDAO dao = new CompromissoDAO();
		ArrayList<Compromisso> compromissos = new ArrayList<>();
		int status = Integer.parseInt(request.getParameter("status"));
		compromissos = dao.getCompromissos(usuario.getCodUsuario(), status);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
		<title>Agenda El�tronica</title>
	</head>
	<body>
		<!-- CABE�ALHO DA PAGINA -->
		<%@include file="header.html"%>
		
		<!-- CONTEUDO DA PAGINA -->
		<div class="container mt-3">
			<div class="row">
				<!-- COLUNA ESQUERDA -->
				<div class="col-md-3">
					<%@include file="painel-usuario.jsp"%>
					<%@include file="painel-menu.html"%>
				</div>
				
				<!-- COLUNA DIREITA -->
				<div class="col-md-9">
					<div class="card">
						<div class="card-header bg-dark text-white row">
							<div class="col-md-8"><h5>Meus compromissos</h5></div>
							<div class="col-md-4 text-right"><a class="text-white" href="cadastrar-compromisso.jsp">Adicionar novo compromisso</a></div>
						</div>	
						<div class="card-body">
							<div class="row">
								<div class="col-md-4">
								<label for="combo-status">Status:</label>
									<select class="form-control" id="combo-status" name="combo-status">
										<option value="0" <%= status == 0 ? "selected" : ""  %>>Em andamento</option>
										<option value="1" <%= status == 1 ? "selected" : ""  %>>Cancelado</option>
										<option value="2" <%= status == 2 ? "selected" : ""  %>>Concluido</option>
									</select>
								</div>
								<div class="col-md-8"></div>
							</div>
							<table class="table table-bordered table-dark table-sm mt-3 table-hover">
								<thead>
									<th>C�digo</th>
									<th>Compromisso</th>
									<th>Data</th>
									<th></th>
								</thead>
								<tbody>
									<% for(Compromisso c : compromissos){ %>
									<tr>
										<th><%= String.format("%06d", c.getCod_compromisso()) %></th>
										<td><a class="text-white" href="#"><%= c.getTitulo() %></a></td>
										<td><%= c.getData() %></td>
										<td><a class="text-white" href="#"><img src="imagens/icon_block.png"></a></td>
									</tr>
									<% } %>
								</tbody>
							</table>
						</div>
						<div class="card-footer"></div>
					</div>
				</div>
			</div>
		</div>
		<script src="js/compromissos.js"></script>
	</body>
</html>
<% } %>