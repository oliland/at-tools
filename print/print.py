#!/usr/bin/env python
import subprocess


class Printer(object):
    """
    A printer in Appleton Tower.
    
    This class is responsible for reporting the status of a printer and
    printing documents that are sent to it.
    """
    def __init__(self, name, floor):
        self.name = name
        self.floor = floor
    
    def print_document(self, document, copies = 1):
        """Prints a document."""
        
        arguments = ""
        
        if (copies != 1):
            arguments += "-# %s " % (copies)
        
        command = "lpr" + arguments + document
        
        subprocess.Popen(command, shell=True, stdout=subprocess.PIPE)