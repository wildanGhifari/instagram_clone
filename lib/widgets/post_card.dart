import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends StatelessWidget {
  final dynamic snap;
  const PostCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // POST'S HEADER =====================================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                        snap['profImage'],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      snap['username'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shrinkWrap: true,
                          children: ["Delete"]
                              .map(
                                (e) => InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                    child: Text(e),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_horiz),
                )
              ],
            ),
          ),
          // IMAGE SECTION =====================================================
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.50,
            width: double.infinity,
            child: Image.network(
              snap['postUrl'],
              fit: BoxFit.cover,
            ),
          ),
          // POST'S DETAILS ====================================================
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border_rounded),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.comment_outlined),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bookmark_border_rounded),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${snap['likes'].length} likes",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: snap['username'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: " ${snap['caption']}",
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        child: const Text(
                          "View all 200 comments",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        timeago.format(snap['datePublished'].toDate(),
                            locale: 'en'),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
