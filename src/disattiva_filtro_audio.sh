#!/bin/bash

jack_disconnect amsfiltro_cuffie_1:out_0 system:playback_1
jack_disconnect amsfiltro_cuffie_1:out_1 system:playback_2
jack_disconnect system:capture_1 amsfiltro_cuffie_1:in_1
jack_disconnect system:capture_1 amsfiltro_cuffie_1:in_0
jack_connect system:capture_1 system:playback_1
jack_connect system:capture_1 system:playback_2

