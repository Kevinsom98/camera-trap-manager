import 'package:camera_trap_app/ui/projects_details_ui.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/db_model.dart';
import '../services/helper_service.dart';


class ProjectDashboard extends StatefulWidget {
  const ProjectDashboard({super.key});

  @override
  State<ProjectDashboard> createState() => _ProjectDashboardState();
}

class _ProjectDashboardState extends State<ProjectDashboard> {
  final DriftService _dbService = DriftService();
  final TextEditingController _nameController = TextEditingController();
  List<ProjectFolder> _projects = [];

  @override
  void initState() {
    super.initState();
    _refreshProjects();
  }

  void _refreshProjects() async {
    final data = await _dbService.getAllProjects();
    setState(() => _projects = data);
  }

  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Project Folder'),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: 'Project Name'),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (_nameController.text.trim().isEmpty) return;
              final proj = ProjectFoldersCompanion.insert(
                uuid: const Uuid().v4(),
                name: _nameController.text.trim(),
                dateCreated: DateTime.now(),
              );
              await _dbService.saveProject(proj);
              _nameController.clear();
              Navigator.pop(context);
              _refreshProjects();
            },
            child: const Text('Create'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera Trap Folders')),
      body: _projects.isEmpty
          ? const Center(child: Text('No project directories established yet.'))
          : ListView.builder(
  padding: const EdgeInsets.only(top: 8, bottom: 80), // Prevent FAB from hiding the last item
  itemCount: _projects.length,
  itemBuilder: (context, itemIndex) {
    final project = _projects[itemIndex];
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetailScreen(project: project),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.folder_special, 
                  color: Theme.of(context).colorScheme.primary, 
                  size: 32
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Created: ${project.dateCreated.toString().split(' ')[0]}',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  },
),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDialog,
        child: const Icon(Icons.create_new_folder),
      ),
    );
  }
}