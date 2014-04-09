/*  ----HOME---             
/*  Document   : funcionesHome
    Created on : 20-may-2013, 13:32:05
    Author     : elopez
 */

$(document).ready(function(){
    $("#scrollbar1").tinyscrollbar();
    
    $(".radioExp").click(function(){
                                    $("#divtodo").css("display","none");
                                    $("#divpeliculas").css("display","none");
                                    $("#divpersona").css("display","none");
                                    $("#divfestival").css("display","none");
                                    $("#divpremio").css("display","none");
                                    $("#divtematico").css("display","none");
                                    var div="#div"+this.value;
                                     $(div).css("display","block")
                                     $("#txtbusqueda"+this.value).css("display","block")
                                    }
                        );
    
    //Muestra / Oculta MENU
 $("#menuQuienes").mouseover(function() {
    $("#submenuQuienes").toggle();
  }).mouseout(function(){
    $("#submenuQuienes").toggle();
  });
  
  $("#menuCartelera").mouseover(function() {
    $("#submenuCartelera").toggle();
  }).mouseout(function(){
    $("#submenuCartelera").toggle();
  });
  
  $("#menuAcervos").mouseover(function() {
    $("#submenuAcervos").toggle();
  }).mouseout(function(){
    $("#submenuAcervos").toggle();
  });
  
  $("#menuDocumentacion").mouseover(function() {
    $("#submenuDocumentacion").toggle();
  }).mouseout(function(){
    $("#submenuDocumentacion").toggle();
  });
  
  
  $("#menuPublicaciones").mouseover(function() {
    $("#submenuPublicaciones").toggle();
  }).mouseout(function(){
    $("#submenuPublicaciones").toggle();
  });
  
  $("#menuExhibicion").mouseover(function() {
    $("#submenuExhibicion").toggle();
  }).mouseout(function(){
    $("#submenuExhibicion").toggle();
  });
  
  $("#menuTransparencia").mouseover(function() {
    $("#submenuTransparencia").toggle();
  }).mouseout(function(){
    $("#submenuTransparencia").toggle();
  });
  
  
  
  
  
  
  
});



function selectMenu(opt){
                        html='';
                        $.post("/sitioWeb2013/php/"+opt+".php","",function(data) {$("#muestraContenido").html("");$("#muestraContenido").html(data);});
                        }
function selectMenuDet(opt){
                        html='';
                        $.post("../php/"+opt+".php","",function(data) {$("#muestraContenido").html(data)});
                        }
                       
function selectPelicula(opt,param){
                        html='';
                        $.post("php/"+opt+".php?clv="+param,"",function(data) {$("#muestraContenido").html(data)});
                        }                       

function calendarioHoriz(mes){
                           
                            $.post("php/calendarioHoriz.php",{mes: mes},function(data) {$("#mas_fechas").html("");$("#mas_fechas").html(data);});
                           }

function enviaMensaje(){
 			if($("#nombre").get(0).value ==""){
 				alert("Por favor escribe tu nombre.");
 				$("#nombre").focus();
 				return;
 			 }
 			if($("#correo").get(0).value ==""){
				alert("Por favor escribe tu direccion de correo.");
				$("#correo").focus();
				return;
			 }
 			if($("#asunto").get(0).value ==""){
				alert("Por favor escribe el titulo del mesaje.");
				$("#asunto").focus();
				return;
			 }
 			if($("#mensaje").get(0).value ==""){
				alert("Por favor escribe el mensaje.");
				$("#mensaje").focus();
				return;
			 }
 			 $.get("php/correo.php?btnEnviar=Enviar",$("#forma").serialize(),function(data){
 				$("#resultado").html(data);
 				limpiarMsg(false);
 			 });	  
 		 }
 function limpiarMsg(flag){
 			$("#nombre").get(0).value ="";
 			$("#correo").get(0).value ="";
 			$("#asunto").get(0).value ="";
 			$("#mensaje").get(0).value ="";			  
 			if (flag==true){
 			  $("#resultado").html("");
 			} 
 		 }
                 
 function cambio_idioma(){
    var idioma=document.getElementById("select_idioma").value;
    var ajax=nuevoAjax();
    //alert(idioma);
    ajax.open("GET", "./inicio.php?idioma="+idioma, true);
    ajax.onreadystatechange=function(){
        if (ajax.readyState==4){
            document.location.href = document.location.href;
        }
    }
    ajax.send(null);
}

function nuevoAjax()
{
// ------------------------------------------------------------------------------------- Crea el objeto AJAX. Esta funcion es generica para cualquier utilidad de este tipo, por
// ------------------------------------------------------------------------------------- lo que se puede copiar tal como esta aqui 
	var xmlhttp=false;
	try
	{
// ------------------------------------------------------------------------------------- Creacion del objeto AJAX para navegadores no IE
		xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e)
	{
		try
		{
// ------------------------------------------------------------------------------------- Creacion del objeto AJAX para IE
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		catch(E) { xmlhttp=false; }
	}
	if (!xmlhttp && typeof XMLHttpRequest!='undefined') { xmlhttp=new XMLHttpRequest(); }
 
	return xmlhttp;
}





/*Noticias*/
 function  noticiasAnio(periodo){
 			 $.get("controlador.php",{id:"h",anio:periodo,opcion:"noticias"},function(data){
				$("#cuerpo").html(data);
			});
 		  }
/*Encuesta Transparencia*/          
function enviaEncuesta(){
    if($("input[name='pre_1']:checked").length==""){
 				alert("Por favor contesta la primera pregunta.");
 				$("#pre_1").focus();
 				return;
 			 }
    if($("input[name='pre_2a']:checked").length==""){
 				alert("Por favor contesta la segunda pregunta.");
 				$("#pre_2_1").focus();
 				return;
 			 }
    if($("input[name='pre_2b']:checked").length==""){
 				alert("Por favor contesta la tercera pregunta.");
 				$("#pre_2_2").focus();
 				return;
 			 }
   if($("input[name='pre_2c']:checked").length==""){
 				alert("Por favor contesta la cuarta pregunta.");
 				$("#pre_2_3").focus();
 				return;
 			 }
   if($("input[name='pre_3']:checked").length==""){
 				alert("Por favor contesta la quinta pregunta.");
 				$("#pre_3").focus();
 				return;
 			 }
   if($("input[name='pre_4']:checked").length==""){
 				alert("Por favor contesta la sexta pregunta.");
 				$("#pre_4").focus();
 				return;
 			 }
  if($("#pre_5").val()==""){
 				alert("Por favor contesta la ultima pregunta.");
 				$("#pre_5").focus();
 				return;
 			 }
  $.post("php/transparencia/encuestaEnvio.php",$("#frmEncuesta").serialize(),function(data) {$("#enviaEncuesta").html(""); $("#enviaEncuesta").html(data);});
              
             
}