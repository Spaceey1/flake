vec4 close_color(vec3 coords_geo, vec3 size_geo) {
	float yCutoff = sin(niri_clamped_progress * 1.57);
	float cutoffDistance = 1.0 - log(abs(yCutoff - coords_geo.y) * 100.0);
	if(coords_geo.y > yCutoff){ 
		vec4 color = texture2D(niri_tex, coords_geo.st);
		color.b *= max(cutoffDistance * 5.0, 1.0);
		color.rg *= max(cutoffDistance * 3.0, 1.0);
		return color; 
	}
	
	return vec4(0,0,0,0);
}
