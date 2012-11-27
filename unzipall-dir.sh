#!/bin/sh
for x in *.zip; do echo "$x"; unzip -d "${x%.zip}" "$x"; done