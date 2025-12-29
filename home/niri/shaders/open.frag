vec4 open_color(vec3 coords_geo, vec3 size_geo) {
	float yCutoff = cos(niri_progress * 1.57);
	if(coords_geo.y > yCutoff){ 
		vec4 color = texture2D(niri_tex, coords_geo.st);
		return color; 
	}
	
	return vec4(0,0,0,0);
}
