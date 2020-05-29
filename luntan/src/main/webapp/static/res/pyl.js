//点击搜索
$("#sou").click(function(){
	var souword =$("#soucontent").val();
	if(souword==""){return;}
	window.location="pyl/souPosts.do?souword="+souword;


});