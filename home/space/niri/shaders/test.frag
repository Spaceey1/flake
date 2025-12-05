vec4 close_color(vec3 coords_geo, vec3 size_geo) {
	float yCutoff = niri_clamped_progress
	if(coords_geo.y > yCutoff){ 
		vec4 color = texture2D(niri_tex, coords_geo.st);
		return color; 
	}
	
	return vec4(0,0,0,0);
}
