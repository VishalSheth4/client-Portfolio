import 'package:flutter/material.dart';
import 'services/excel_service.dart';
import 'theme/app_theme.dart';
import 'widgets/hover_card.dart';
import 'theme/page_styles.dart';
import 'utils/responsive_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SubmissionsPage extends StatefulWidget {
  const SubmissionsPage({super.key});

  @override
  State<SubmissionsPage> createState() => _SubmissionsPageState();
}

class _SubmissionsPageState extends State<SubmissionsPage> {
  List<Map<String, String>> _submissions = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String _sortBy = 'Date';
  bool _sortAscending = false;
  String _selectedStatus = 'All';
  bool _showDeleteDialog = false;
  Map<String, String>? _selectedSubmission;

  @override
  void initState() {
    super.initState();
    _loadSubmissions();
  }

  Future<void> _loadSubmissions() async {
    setState(() => _isLoading = true);
    try {
      final submissions = await ExcelService.getSubmissions();
      setState(() {
        _submissions = submissions;
        _sortSubmissions();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading submissions: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _sortSubmissions() {
    _submissions.sort((a, b) {
      if (_sortBy == 'Date') {
        return _sortAscending
            ? a['Date']!.compareTo(b['Date']!)
            : b['Date']!.compareTo(a['Date']!);
      } else if (_sortBy == 'Name') {
        return _sortAscending
            ? a['Name']!.compareTo(b['Name']!)
            : b['Name']!.compareTo(a['Name']!);
      }
      return 0;
    });
  }

  List<Map<String, String>> get _filteredSubmissions {
    var filtered = _submissions;
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((submission) {
        final name = submission['Name']?.toLowerCase() ?? '';
        final email = submission['Email']?.toLowerCase() ?? '';
        final message = submission['Message']?.toLowerCase() ?? '';
        final query = _searchQuery.toLowerCase();
        return name.contains(query) ||
            email.contains(query) ||
            message.contains(query);
      }).toList();
    }

    // Filter by status
    if (_selectedStatus != 'All') {
      filtered = filtered.where((s) => s['Status'] == _selectedStatus).toList();
    }

    return filtered;
  }

  Future<void> _deleteSubmission(Map<String, String> submission) async {
    setState(() => _showDeleteDialog = true);
    try {
      // Show confirmation dialog
      final shouldDelete = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Submission'),
          content: const Text('Are you sure you want to delete this submission?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        ),
      );

      if (shouldDelete == true) {
        setState(() {
          _submissions.remove(submission);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Submission deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } finally {
      setState(() => _showDeleteDialog = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveHelper.isMobile(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Form Submissions',
          style: TextStyle(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadSubmissions,
            color: AppTheme.primaryColor,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _submissions.isEmpty
              ? _buildEmptyState()
              : _buildContent(isMobile),
    );
  }

  Widget _buildContent(bool isMobile) {
    return Column(
      children: [
        _buildSearchAndFilter(isMobile),
        Expanded(
          child: _filteredSubmissions.isEmpty
              ? _buildNoResultsFound()
              : _buildSubmissionsList(isMobile),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilter(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            onChanged: (value) => setState(() => _searchQuery = value),
            decoration: InputDecoration(
              hintText: 'Search submissions...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => _searchQuery = ''),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text(
                  'Filter by:',
                  style: TextStyle(
                    color: AppTheme.textColor.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                for (final status in ['All', 'New', 'Read'])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(status),
                      selected: _selectedStatus == status,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _selectedStatus = status);
                        }
                      },
                    ),
                  ),
                const SizedBox(width: 16),
                Text(
                  'Sort by:',
                  style: TextStyle(
                    color: AppTheme.textColor.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Date'),
                  selected: _sortBy == 'Date',
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _sortBy = 'Date';
                        _sortSubmissions();
                      });
                    }
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Name'),
                  selected: _sortBy == 'Name',
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _sortBy = 'Name';
                        _sortSubmissions();
                      });
                    }
                  },
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    _sortAscending
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                  ),
                  onPressed: () {
                    setState(() {
                      _sortAscending = !_sortAscending;
                      _sortSubmissions();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: AppTheme.primaryColor.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No submissions yet',
            style: TextStyle(
              fontSize: 20,
              color: AppTheme.textColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmissionsList(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageStyles.buildGradientTitle(
            'Recent Submissions',
            fontSize: isMobile ? 24 : 32,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSubmissions.length,
              itemBuilder: (context, index) {
                final submission = _filteredSubmissions[index];
                return _buildSubmissionCard(submission, isMobile);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmissionCard(Map<String, String> submission, bool isMobile) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: HoverCard(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    submission['Name'] ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.mark_email_read),
                      onPressed: () {
                        setState(() {
                          submission['Status'] = 'Read';
                        });
                      },
                      tooltip: 'Mark as read',
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _deleteSubmission(submission),
                      tooltip: 'Delete submission',
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: submission['Status'] == 'New'
                            ? Colors.green.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        submission['Status'] ?? 'New',
                        style: TextStyle(
                          color: submission['Status'] == 'New'
                              ? Colors.green
                              : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              submission['Email'] ?? '',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.textColor.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              submission['Message'] ?? '',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.textColor.withOpacity(0.8),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Submitted on: ${submission['Date'] ?? ''}',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textColor.withOpacity(0.6),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResultsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: AppTheme.primaryColor.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: TextStyle(
              fontSize: 20,
              color: AppTheme.textColor.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
} 