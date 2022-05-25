def get_edges(position_table, use_orientation = False):
    edges = []
    for index in position_table:
        edge = set()
        for contig, orientation in position_table[index]:
            if use_orientation:
                contig = (contig, orientation)
            edge.add(contig)
        
        # Skip edges with telomeres. 
        if len(edge) < 2:
            continue

        edges.append(edge)
    
    return edges

def count(first, second, orientation = False):
    first_contigs, first_positions = first
    second_contigs, second_positions = second

    first_connections = get_edges(first_positions, orientation)
    second_connections = get_edges(second_positions, orientation)

    weighted_first = 0
    weighted_second = 0
    for edge in first_connections:
        
        # Add the edge weight.
        current_weight = 0
        for contig in edge:
            if orientation:
                contig = contig[0]
            current_weight += first_contigs[contig]['length']
        weighted_first += current_weight
    
        # If the edge is in the other assembly, count it and weight it. 
        if edge in second_connections:
            weighted_second += current_weight
    
    return weighted_second / weighted_first