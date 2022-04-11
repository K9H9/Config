#!/bin/sh

done=$(todo raw done | wc -l)
undone=$(todo raw todo | wc -l)
total=$(todo list | wc -l)



echo "$done@@$undone"