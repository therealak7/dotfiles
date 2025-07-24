#!/usr/bin/env bash

getVolume ()
{
    wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}'
}

getVolume

DEFAULT_SINK=$(wpctl inspect @DEFAULT_SINK@ | awk '/^id [0-9]+/ { print $2 }' | sed 's/,//')

pw-mon -pao | rg --line-buffered 'id: 52' | while read -r _; do
    getVolume
done

