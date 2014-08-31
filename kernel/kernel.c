void start(void) {
	// Pointteri osoittamaan video muistin ensimmäiseen lohkoon
	char* video_memory = (char*) 0xb80A0;
	*video_memory = 'T';
	video_memory = (char*) 0xb80A2;
	*video_memory = 'E';
	video_memory = (char*) 0xb80A4;
	*video_memory = 'R';
	video_memory = (char*) 0xb80A6;
	*video_memory = 'V';
	video_memory = (char*) 0xb80A8;
	*video_memory = 'E';
}